//
//  NetworkManager.swift
//  CocktailBook
//
//  Created by Sujoy Adhikary on 28/11/24.
//

enum CustomError : Error {
    case invalidURL
    case decodingError(message : String)
    case noData
    case response(code : Int, message : String)
    case customError(code : Int, message : String)
    case unknownError
}



protocol NetworkManagerProtocol : AnyObject {
    func fetch<T:Codable>(type : T.Type, completion: @escaping (Result<T, Error>) -> Void)
}


class NetworkManager : NetworkManagerProtocol{
        
    private let fetcher: CocktailsAPI
    private let decoder: ResponseHandlerProtocol
    
    init(fetcher: CocktailsAPI = FakeCocktailsAPI(withFailure: .count(2)),
         decoder: ResponseHandlerProtocol = ResponseHandler()){
        self.fetcher = fetcher
        self.decoder = decoder
    }
    
    
    func fetch<T:Codable>(type : T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        _ = fetcher.fetchCocktails { [weak self] result in
            switch result {
            case .success(let data):
                if let response = self?.decoder.decodeResponse(type: T.self, data: data){
                    completion(response)
                }else{
                    completion(.failure(CustomError.unknownError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


