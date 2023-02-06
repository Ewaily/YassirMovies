//
//  MoviesListUseCase.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

protocol MoviesListUseCaseProtocol {
    func getMovies()
}

protocol MoviesListUseCaseResponseDelegate: AnyObject {
    func getMoviesSuccess(movies: Movies)
    func getMoviesFailed(error: NetworkError)
}

class MoviesListUseCase {
    // MARK: - Private properties -

    // MARK: - Public properties -
    
    var repository: MoviesRepositoryProtocol?
    weak var delegate: MoviesListUseCaseResponseDelegate?
    
    // MARK: - Init -
    
    init(repository: MoviesRepositoryProtocol? = nil, delegate: MoviesListUseCaseResponseDelegate? = nil) {
        if repository != nil {
            self.repository = repository!
        } else {
            self.repository = MoviesRepository(delegate: self)
        }
        
        self.delegate = delegate
    }
}

// MARK: - Extensions -

extension MoviesListUseCase: MoviesListUseCaseProtocol {
    func getMovies() {
        repository?.getMovies()
    }
}

extension MoviesListUseCase: MoviesRepositoryResponseDelegate {
    func getMoviesSuccess(jsonResponse: String) {
        let responseData = Data(jsonResponse.utf8)
        let successResult = responseData.decode(class: Movies.self)
        
        switch successResult {
        case .success(let moviesResult):
            delegate?.getMoviesSuccess(movies: moviesResult)
            
        case .failure:
            delegate?.getMoviesFailed(error: NetworkError.decodingError)
        }
    }
    
    func getMoviesFailed(error: NetworkError) {
        delegate?.getMoviesFailed(error: error)
    }
}
