//
//  MyTableCell.swift
//  SinglePage
//
//  Created by Surendra Mahawar on 14/07/25.
//

import UIKit

class MyTableCell: UITableViewCell {
    
    static let Identifier = "DefaultLoadsCell"
    
    private let myImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(myImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            myImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            myImageView.widthAnchor.constraint(equalToConstant: 80),
            myImageView.heightAnchor.constraint(equalToConstant: 80),
            myImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            
            titleLabel.topAnchor.constraint(equalTo: myImageView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            descLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with movie: Search) {
        titleLabel.text = movie.title
        descLabel.text = "Year: \(movie.year ?? "")"
        loadImage(from: movie.poster ?? "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg")
    }
    
    private func loadImage(from urlString: String) {
        myImageView.image = nil
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.myImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
