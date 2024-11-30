//
//  CocktailMockService.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 28/11/24.
//

import Foundation
@testable import CocktailBook


class MockCocktailService : CocktailServiceProtocol {
    
    private let decoder: ResponseHandlerProtocol
    
    init(decoder: ResponseHandlerProtocol = ResponseHandler()) {
        self.decoder = decoder
    }
    
    func fetchCocktails(_ handler: @escaping ([CocktailDataModelResponse]?, String?) -> Void) {
        guard let data = readJsonFile() else {
            handler(nil, LocalString.errorReadingFile)
            return
        }
        
        let response = decoder.decodeResponse(type: [CocktailDataModelResponse].self, data: data)
        switch response {
        case .success(let success):
            if success.isEmpty {
                handler(nil, LocalString.noDataFound)
                return
            }
            handler(success, nil)
        case .failure(let failure):
            handler(nil, failure.localizedDescription)
        }
    }
    
    
    func readJsonFile() -> Data? {
        guard let file = Bundle.main.url(forResource: "sample", withExtension: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: file) else {
            return nil
        }
        return data
    }
    
}
