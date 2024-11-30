//
//  ProductDetailViewModel.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 28/11/24.
//

import Combine


class ProductDetailViewModel : BaseViewModel{
    
    @Published var product : CocktailDataModelResponse
    
    init(product: CocktailDataModelResponse) {
        self.product = product
        
    }
    
    func favoriteButtonTapped(){
        guard product.isFavorite != nil else {
            product.isFavorite = true
            return
        }
        product.isFavorite?.toggle()
    }
    
    deinit {
//        print("\(self) deinit")
    }
    
}
