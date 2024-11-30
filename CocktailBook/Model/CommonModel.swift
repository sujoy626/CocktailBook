//
//  Common.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 29/11/24.
//

enum CocktailFilterType: Hashable, CaseIterable{
    case all
    case alcoholic
    case nonAlcoholic
}

extension CocktailFilterType{
    var title: String{
        switch self {
        case .all:
            return "All"
        case .alcoholic:
            return "Alcoholic"
        case .nonAlcoholic:
            return "Non-Alcoholic"
        }
    }
}
