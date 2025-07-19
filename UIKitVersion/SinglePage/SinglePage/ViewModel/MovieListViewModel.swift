//
//  MovieListViewModel.swift
//  SinglePage
//
//  Created by Surendra Mahawar on 14/07/25.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {

    // MARK: - Properties
    @Published var movies: [Search] = []
    @Published var errorMessage: String = ""
    private var cancellables = Set<AnyCancellable>()

    // MARK: - API Call
    func fetchMovies() {
        NetworkManager.shared.fetchData()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.errorMessage = self?.mapError(error) ?? "error"
                }
            } receiveValue: { response in
                self.movies = response.search ?? []
            }
            .store(in: &cancellables)
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

