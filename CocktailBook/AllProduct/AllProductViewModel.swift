//
//  AllProductViewModel.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 27/11/24.
//

import Foundation




class AllProductViewModel : BaseViewModel{
    enum ViewState : Hashable{
        case initial
        case loading(String)
        case loaded
        case empty(String)
        case error(String)
    }
    
    @Published private(set) var viewState : ViewState = .empty("Please press refresh[↻]") // .initial
    
    
    
    let filterOptionsTypes = CocktailFilterType.allCases
    @Published var selectedFilterType: CocktailFilterType = .all
    
    @Published /*private*/ var cocktailsStorage = [CocktailDataModelResponse]()
    @Published /*private(set)*/ var cocktails = [CocktailDataModelResponse]()
    
    
    
    private let service: CocktailServiceProtocol
    
    init(service: CocktailServiceProtocol){
        self.service = service
        
        super.init()
        
//        loadCocktails()
        setupObserver()
    }
    
    
    private func setupObserver(){
        $cocktailsStorage
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                doFilter(with: self.selectedFilterType)
            }
            .store(in: &cancellableBag)
        
        
        $selectedFilterType
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] type in
                guard let self = self else { return }
                doFilter(with: type)
            }
            .store(in: &cancellableBag)
    }
    
    
    
     func doFilter(with type : CocktailFilterType){
        switch type {
        case .all:
            cocktails = cocktailsStorage
        case .alcoholic:
            cocktails = cocktailsStorage.filter { $0.type == .alcoholic }
        case .nonAlcoholic:
            cocktails = cocktailsStorage.filter { $0.type == .nonAlcoholic }
        }
    }
    
        func updateViewState(_ state: ViewState){
            DispatchQueue.main.async{ [weak self] in
                self?.viewState = state
            }
        }
    
}

extension AllProductViewModel{
    func updateItem(item: CocktailDataModelResponse){
        guard let index = cocktailsStorage.firstIndex(where: { $0.id == item.id }) else { return }
        cocktailsStorage[index].isFavorite = item.isFavorite
    }
}


extension AllProductViewModel{
    func fetchAllCocktail(){
        loadCocktails()
    }
    
    private func loadCocktails() {
        self.updateViewState(.loading(LocalString.fetching))
        Task {
             service.fetchCocktails { [weak self] model, errorMsg in
                guard let self = self else { return }
                self.updateViewState(.loaded)
                
                if let message = errorMsg {
                    self.updateViewState(.error(message))
                    return
                }
                
                
                guard let model = model, !model.isEmpty else {
                    self.updateViewState(.empty(LocalString.noDataFound))
                    return
                }
                
                
                DispatchQueue.main.async{ [weak self] in
                    self?.cocktailsStorage = model
                }
            }
        }
    }
    
}
