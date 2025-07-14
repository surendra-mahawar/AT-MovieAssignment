//
//  MovieListView.swift
//  SinglePageSwiftUI
//
//  Created by Surendra Mahawar on 14/07/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.imdbID) { movie in
                MovieRowView(movie: movie)
            }
            .navigationTitle("Movies List")
            .task {
                await viewModel.fetchMovies()
            }
            .alert(isPresented: $viewModel.showError) {
                Alert(title: Text("Oops"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}
