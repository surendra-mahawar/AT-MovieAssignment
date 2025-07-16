//
//  MovieListViewModel.swift
//  SinglePageSwiftUI
//
//  Created by Surendra Mahawar on 14/07/25.
//

import Combine

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies: [Search] = []
    @Published var showError = false
    @Published var errorMessage = ""


    func fetchMovies() async {
        do {
            let response = try await NetworkManager.shared.fetchData()
            self.movies = response.search ?? []
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
