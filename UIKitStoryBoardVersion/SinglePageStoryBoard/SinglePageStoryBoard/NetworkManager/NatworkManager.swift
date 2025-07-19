//
//  NatworkManager.swift
//  SinglePageStoryBoard
//
//  Created by XP India on 19/07/25.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completion: @escaping (Result<MovieResponse, DataError>) -> Void) {
        let urlString = "https://www.omdbapi.com/?apikey=2c0d1dab&s=dark"
        guard let url = URL(string: urlString) else {
            completion(.failure(DataError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        .resume()
    }
}


enum DataError: Error {
    case invalidURL
    case decodingFailed
    case noData
    case networkError(error: Error)
}
