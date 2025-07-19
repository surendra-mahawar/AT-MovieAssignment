//
//  MovieResposeViewModel.swift
//  SinglePageStoryBoard
//
//  Created by XP India on 19/07/25.
//

import Foundation

protocol MovieResposeViewModelProtocol {
    func reciveData()
    func reciveError(error: String)
}

class MovieResposeViewModel {
    
    var movies = [Search]()
    var error: String?
    var delegate: MovieResposeViewModelProtocol?
    
    func fetchMovies() {
        NetworkManager.shared.fetchData { [weak self] result in
            guard let self else { return}
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.movies = success.search ?? []
                    self.delegate?.reciveData()
                case .failure(let failure):
                    self.delegate?.reciveError(error: failure.localizedDescription)
                }
            }
        }
    }
}
