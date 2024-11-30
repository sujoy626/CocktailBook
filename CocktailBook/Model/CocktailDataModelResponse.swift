//
//  CocktailDataModel.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 27/11/24.
//

import Foundation

struct CocktailDataModelResponse: Codable, Hashable {
    let id : String
    let name: String
    let type: TypeEnum
    let shortDescription, longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    
    
    var isFavorite: Bool?
    
    enum TypeEnum: String, Codable,Hashable {
        case alcoholic = "alcoholic"
        case nonAlcoholic = "non-alcoholic"
    }
    
}

//MARK: - preview
extension CocktailDataModelResponse {
    static var itemMojito : CocktailDataModelResponse {
        .init(id: "1", name: "Mojito", type: .alcoholic, shortDescription: "Mojito", longDescription: "The Piña Colada is a Puerto Rican rum drink made with pineapple juice (the name means “strained pineapple” in Spanish) and cream of coconut. By most accounts, the modern-day Piña Colada seems to have originated from a 1954 version that bartender named Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel in San Juan, Puerto Rico. While you may not be sipping this icy-cold tiki drink on the beaches of Puerto Rico, it’s sure to get you in a sunny mood no matter the season.", preparationMinutes: 10, imageName: "mojito", ingredients: ["Lemon", "Mint", "Sugar", "Soda"])
    }
}
