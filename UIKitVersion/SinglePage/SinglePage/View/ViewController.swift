//
//  ViewController.swift
//  SinglePage
//
//  Created by Surendra Mahawar on 14/07/25.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel = MovieListViewModel()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MyTableCell.self, forCellReuseIdentifier: MyTableCell.Identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindViewModel()
        viewModel.fetchMovies()
    }
    
    private func configureUI() {
        title = "Movies List"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableCell.Identifier, for: indexPath) as! MyTableCell
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
}
