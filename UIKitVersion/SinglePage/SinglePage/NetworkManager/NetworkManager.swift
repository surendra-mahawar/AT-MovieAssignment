//
//  NetworkManager.swift
//  SinglePage
//
//  Created by Surendra Mahawar on 14/07/25.
//

import Foundation
import Combine

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    private init() {}
    
    func fetchData() -> AnyPublisher<MovieResponse, DataError> {
        let urlString = "https://www.omdbapi.com/?apikey=2c0d1dab&s=dark"
        guard let url = URL(string: urlString) else {
            return Fail(error: DataError.badURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return DataError.decodingError
                } else {
                    return DataError.networkError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

enum DataError: Error {
    case badURL
    case noData
    case decodingError
    case networkError(Error)
}
