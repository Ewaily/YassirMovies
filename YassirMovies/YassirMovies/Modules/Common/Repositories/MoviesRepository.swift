//
//  MoviesRepository.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func getMovies()
}

protocol MoviesRepositoryResponseDelegate: AnyObject {
    func getMoviesSuccess(jsonResponse: String)
    func getMoviesFailed(error: NetworkError)
}

extension MoviesRepositoryResponseDelegate {
    func getMoviesSuccess(jsonResponse: String) {}
    func getMoviesFailed(error: NetworkError) {}
}

class MoviesRepository {
    // MARK: - Public properties -
    
    weak var delegate: MoviesRepositoryResponseDelegate?
    var networkManager = NetworkManager.sharedInstance
    
    // MARK: - Init -
    
    init(delegate: MoviesRepositoryResponseDelegate? = nil) {
        self.delegate = delegate
    }
}

// MARK: - Extensions -

extension MoviesRepository: MoviesRepositoryProtocol {
    func getMovies() {
        networkManager.request(requestModel: MoviesRequests.listMovies) { [weak self] (result: Swift.Result<String, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let moviesJSON):
                self.delegate?.getMoviesSuccess(jsonResponse: moviesJSON)
                
            case .failure(let error):
                self.delegate?.getMoviesFailed(error: error)
            }
        }
    }
}
