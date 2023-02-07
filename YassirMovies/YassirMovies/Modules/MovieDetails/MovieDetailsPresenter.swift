//
//  MovieDetailsPresenter.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

protocol MovieDetailsPresenterProtocol {
    func viewDidLoad()
    func getMoviePosterURL() -> URL?
    func getMovieTitle() -> String
    func getMovieReleaseDate() -> String
    func getMovieOverView() -> String
}

protocol MovieDetailsPresenterResponseDelegate: AnyObject {
    func showIndicatorView()
    func hideIndicatorView()
    func showErrorAlert()
    func loadViews()
}

class MovieDetailsPresenter {
    // MARK: - Public properties -
    
    var useCase: MovieDetailsUseCaseProtocol?
    weak var delegate: MovieDetailsPresenterResponseDelegate?
    
    // MARK: - Private properties -
    
    private var currentMovie: Movie?
    private var currentMovieId: Int = 0
    
    // MARK: - Init -
    
    init(useCase: MovieDetailsUseCaseProtocol? = nil, delegate: MovieDetailsPresenterResponseDelegate? = nil, movieId: Int) {
        if useCase != nil {
            self.useCase = useCase!
        } else {
            self.useCase = MovieDetailsUseCase(delegate: self)
        }
        
        self.delegate = delegate
        self.currentMovieId = movieId
    }
}

// MARK: - Extensions -

extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func getMoviePosterURL() -> URL? {
        let url = URL(string: "\(NetworkConstants.IMAGE_BASE_PATH)\(currentMovie?.posterPath ?? "")")
        return url
    }
    
    func getMovieTitle() -> String {
        return currentMovie?.originalTitle ?? ""
    }
    
    func getMovieReleaseDate() -> String {
        return currentMovie?.releaseDate ?? ""
    }
    
    func getMovieOverView() -> String {
        return currentMovie?.overview ?? ""
    }
    
    func viewDidLoad() {
        delegate?.showIndicatorView()
        useCase?.getMovieDetails(movieId: currentMovieId)
    }
}

extension MovieDetailsPresenter: MovieDetailsUseCaseResponseDelegate {
    func getMovieDetailsSuccess(movie: Movie) {
        delegate?.hideIndicatorView()
        self.currentMovie = movie
        delegate?.loadViews()
    }
    
    func getMovieDetailsFailed(error: NetworkError) {
        delegate?.hideIndicatorView()
        delegate?.showErrorAlert()
    }
}
