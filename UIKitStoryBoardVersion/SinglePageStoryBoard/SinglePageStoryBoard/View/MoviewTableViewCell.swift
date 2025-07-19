//
//  MoviewTableViewCell.swift
//  SinglePageStoryBoard
//
//  Created by XP India on 19/07/25.
//

import UIKit

class MoviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(with movie: Search) {
        titleLabel.text = movie.title
        loadImage(from: movie.poster ?? "")
    }
    
    private func loadImage(from urlString: String) {
        cardImageView.image = nil
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.cardImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
