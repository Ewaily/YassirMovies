//
//  MovieDetailsPresenter.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

protocol MovieDetailsPresenterProtocol {
    func getMoviePosterURL() -> URL?
    func getMovieTitle() -> String
    func getMovieReleaseDate() -> String
    func getMovieOverView() -> String
}

protocol MovieDetailsPresenterResponseDelegate: AnyObject {}

class MovieDetailsPresenter {
    // MARK: - Public properties -
    
    var useCase: MovieDetailsUseCaseProtocol?
    weak var delegate: MovieDetailsPresenterResponseDelegate?
    
    // MARK: - Private properties -
    
    var currentMovie: Result?
    
    // MARK: - Init -
    
    init(useCase: MovieDetailsUseCaseProtocol? = nil, delegate: MovieDetailsPresenterResponseDelegate? = nil, movie: Result) {
        if useCase != nil {
            self.useCase = useCase!
        } else {
            self.useCase = MovieDetailsUseCase(delegate: self)
        }
        
        self.delegate = delegate
        self.currentMovie = movie
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
}

extension MovieDetailsPresenter: MovieDetailsUseCaseResponseDelegate {}
