//
//  AllProductView.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 27/11/24.
//

import SwiftUI


struct AllProductView: View {
    @StateObject var viewModel = AllProductViewModel(service: CocktailService())
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes([ .font: UIFont.systemFont(ofSize: 16,weight: .semibold)], for: .normal)
    }
    
    
    var body: some View {
        NavigationStack{
            VStack{
                switch viewModel.viewState {
                case .initial:
                    ProgressView()
                case .loading(let string):
                    ProgressView(string)
                case .loaded:
                    loadedUI()
                case .empty(let string):
                    Text(string)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.gray)
                case .error(let string):
                    Text(string)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.red)
                        
                }
            }
            .navigationTitle(LocalString.allCocktails)
            .onAppear{
//                viewModel.fetchAllCocktail()
            }
            .toolbar {
                if viewModel.cocktailsStorage.isEmpty{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.fetchAllCocktail()
                        } label: {
                            Image(systemName: LocalImage.refresh)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            
        }
    }
    
    
    
    
    @ViewBuilder
    private func loadedUI() -> some View {
        VStack{
            Picker(selection: $viewModel.selectedFilterType) {
                ForEach(viewModel.filterOptionsTypes, id: \.self) { item in
                    Text(item.title)
                }
            } label: {
                EmptyView()
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)
            

            List{
                ForEach(viewModel.cocktails, id: \.id) { cocktail in
                    
                    let isFavourite = cocktail.isFavorite ?? false
                    
                    NavigationLink(value: cocktail) {
                        VStack(alignment: .leading){
                            HStack{
                                Text(cocktail.name)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .padding(.bottom,8)
                                    .foregroundStyle(isFavourite ? Color.Custom.isFavorite : .primary)
                                
                                Spacer()
                                if isFavourite{
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(Color.Custom.isFavorite)
                                }
                            }
                            Text(cocktail.shortDescription)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    
                    
                }
                .listRowBackground(Color.clear)
                .listRowSeparatorTint(.gray)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .navigationDestination(for: CocktailDataModelResponse.self) { item in
                ProductDetailView.init(viewModel: .init(product: item), onFavoriteToggle: { updateItem in
                    withAnimation(.easeInOut(duration: 1)) {
                        viewModel.updateItem(item: updateItem)
                    }
                    
                })
                
            }
            
        }
    }
    
}


#Preview {
    AllProductView()
}

