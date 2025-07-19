//
//  ViewController.swift
//  SinglePageStoryBoard
//
//  Created by XP India on 19/07/25.
//

import UIKit

class ViewController: UIViewController, MovieResposeViewModelProtocol {
    
    private var viewModel = MovieResposeViewModel()
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        movieTableView.rowHeight = UITableView.automaticDimension
        movieTableView.estimatedRowHeight = 140
        
        viewModel.fetchMovies()
    }
    
    func reciveData() {
        movieTableView.reloadData()
    }
    
    func reciveError(error: String) {
        let alert = UIAlertController()
        let yesAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(yesAction)
        self.present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MoviewTableViewCell else { return UITableViewCell()}
        cell.configure(with: viewModel.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
