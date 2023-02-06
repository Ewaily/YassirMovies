//
//  MoviesListTableViewCell.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 16.0
    }
    
    func setupCell(_ model: MoviesListTableViewCellModel) {
        movieTitleLabel.text = model.title
        movieReleaseDateLabel.text = model.releaseDate
        guard let imageURL = URL(string: generateImageFullPath(shortPath: model.imageURL)) else { return }
        posterImageView.load(url: imageURL)
    }
    
    private func generateImageFullPath(shortPath: String) -> String {
        return "\(NetworkConstants.IMAGE_BASE_PATH)\(shortPath)"
    }
}
