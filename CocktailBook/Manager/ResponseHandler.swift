//
//  ResponseHandler.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 28/11/24.
//


import Foundation

protocol ResponseHandlerProtocol {
    func decodeResponse<T:Codable>(type : T.Type,data: Data) -> Result<T,Error>
}


class ResponseHandler : ResponseHandlerProtocol {
    func decodeResponse<T:Codable>(type : T.Type,data: Data) -> Result<T,Error> {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(CustomError.decodingError(message: error.localizedDescription))
        }
    }
}





