//
//  ProductDetailsTest.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 28/11/24.
//

import XCTest
@testable import CocktailBook

class ProductDetailsTest : XCTestCase {
    
    let sut = ProductDetailViewModel(product: CocktailDataModelResponse(id: "1", name: "Mojito", type: .alcoholic, shortDescription: "Short Description", longDescription: "Long Description", preparationMinutes: 5, imageName: "mojito", ingredients: ["Mint Leaves","Lime","Sugar","White Rum"]))
    
    
    func testFavoriteButtonTappedTest(){
        
        XCTAssertNil(sut.product.isFavorite)
        
        
        sut.favoriteButtonTapped()
        XCTAssertTrue(sut.product.isFavorite == true)
        
        
        sut.favoriteButtonTapped()
        XCTAssertFalse(sut.product.isFavorite == true)
    }
    
}
