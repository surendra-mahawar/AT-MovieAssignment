//
//  NetworkManager.swift
//  SinglePageSwiftUI
//
//  Created by Surendra Mahawar on 14/07/25.
//

import Foundation

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    private init() {}
    
    func fetchData() async throws -> MovieResponse {
        let urlString = "https://www.omdbapi.com/?apikey=2c0d1dab&s=dark"
        guard let url = URL(string: urlString) else {
            throw DataError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
            return decoded
        } catch {
            throw DataError.decodingError
        }
    }
}

enum DataError: Error {
    case badURL
    case noData
    case decodingError
    case networkError(Error)
}
