//
//  MovieListViewModel.swift
//  SinglePage
//
//  Created by Surendra Mahawar on 14/07/25.
//

import Foundation

class MovieListViewModel {

    // MARK: - Properties
    var movies: [Search] = []

    var onMoviesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - API Call
    func fetchMovies() {
        NetworkManager.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movies = response.search ?? []
                    self?.onMoviesUpdated?()
                case .failure(let error):
                    self?.onError?(self?.mapError(error) ?? "error")
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

