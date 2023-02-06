//
//  MovieDetailsViewController.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    // MARK: - Public properties -
    
    var presenter: MovieDetailsPresenterProtocol!
    
    // MARK: - IBOutlets -
    
    @IBOutlet private var moviePosterImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var movieReleaseDateLabel: UILabel!
    @IBOutlet private var movieOverViewLabel: UILabel!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        self.navigationItem.title = presenter.getMovieTitle()
        movieTitleLabel.text = presenter.getMovieTitle()
        movieReleaseDateLabel.text = presenter.getMovieReleaseDate()
        movieOverViewLabel.text = presenter.getMovieOverView()
        guard let imageURL = presenter.getMoviePosterURL() else {
            moviePosterImageView.image = UIImage(named: Images.PLACEHOLDER)
            return
        }
        moviePosterImageView.load(url: imageURL)
    }
}

extension MovieDetailsViewController: MovieDetailsPresenterResponseDelegate {}
