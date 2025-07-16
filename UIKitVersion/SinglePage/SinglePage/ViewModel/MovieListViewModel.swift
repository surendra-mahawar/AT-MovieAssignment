//
//  MovieListViewModel.swift
//  SinglePage
//
//  Created by Surendra Mahawar on 14/07/25.
//

import Foundation

extension Notification.Name {
    static let onMoviesUpdated = Notification.Name("onMoviesUpdated")
    static let onError = Notification.Name("onError")
}

class MovieListViewModel {

    // MARK: - Properties
    var movies: [Search] = []

    // MARK: - API Call
    func fetchMovies() {
        NetworkManager.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movies = response.search ?? []
                    NotificationCenter.default.post(name: .onMoviesUpdated, object: nil)
                case .failure(let error):
                    let errorMessage = self?.mapError(error)
                    NotificationCenter.default.post(name: .onError, object: errorMessage)
                }
            }
        }
    }

    private func mapError(_ error: DataError) -> String {
        switch error {
        case .badURL:
            return "The URL is invalid."
        case .noData:
            return "No data received from the server."
        case .decodingError:
            return "Failed to decode the response."
        case .networkError(let err):
            return "Network error: \(err.localizedDescription)"
        }
    }
}

