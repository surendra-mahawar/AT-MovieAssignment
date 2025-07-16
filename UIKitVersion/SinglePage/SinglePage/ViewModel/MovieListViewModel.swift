//
//  MovieListViewModel.swift
//  SinglePage
//
//  Created by Surendra Mahawar on 14/07/25.
//

import Foundation

protocol MovieListViewModelDelegate {
    func onMoviesUpdated()
    func onError(errorMessage: String)
}

class MovieListViewModel {

    // MARK: - Properties
    var movies: [Search] = []
    var delegate: MovieListViewModelDelegate?

    // MARK: - API Call
    func fetchMovies() {
        NetworkManager.shared.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movies = response.search ?? []
                    self?.delegate?.onMoviesUpdated()
                case .failure(let error):
                    let errorMessage = self?.mapError(error) ?? "error"
                    self?.delegate?.onError(errorMessage: errorMessage)
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

