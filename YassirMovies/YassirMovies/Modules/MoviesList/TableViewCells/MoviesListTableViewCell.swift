//
//  MoviesListTableViewCell.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {
    private var task: URLSessionDataTask?

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 16.0
        posterImageView.layer.cornerRadius = 8.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = UIImage(named: Images.PLACEHOLDER)
        task?.cancel()
    }
    
    func setupCell(_ model: MoviesListTableViewCellModel) {
        configurePosterImageViewWith(url: generateImageFullPath(shortPath: model.imageURL))
        movieTitleLabel.text = model.title
        movieReleaseDateLabel.text = model.releaseDate
    }
    
    private func generateImageFullPath(shortPath: String) -> String {
        return "\(NetworkConstants.IMAGE_BASE_PATH)\(shortPath)"
    }
    
    private func configurePosterImageViewWith(url string: String) {
        guard let url = URL(string: string) else { return }

        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.posterImageView.image = image
                }
            }
        }
        task?.resume()
     }
}
