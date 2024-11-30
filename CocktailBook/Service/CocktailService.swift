//
//  CocktailService.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 28/11/24.
//


protocol CocktailServiceProtocol : AnyObject {
    func fetchCocktails(_ handler: @escaping (_ model : [CocktailDataModelResponse]?,_ errorMsg: String?) -> Void)
}

class CocktailService : CocktailServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    func fetchCocktails(_ handler: @escaping (_ model : [CocktailDataModelResponse]?,_ errorMsg: String?) -> Void) {
        networkManager.fetch(type: [CocktailDataModelResponse].self) { result in
            switch result {
            case .success(let data):
                handler(data, nil)
            case .failure(let error):
                print(error.localizedDescription)
                handler(nil, error.localizedDescription)
            }
        }
    }
}
