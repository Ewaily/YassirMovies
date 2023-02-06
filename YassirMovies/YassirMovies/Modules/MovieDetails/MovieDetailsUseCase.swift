//
//  MovieDetailsUseCase.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

protocol MovieDetailsUseCaseProtocol {}

protocol MovieDetailsUseCaseResponseDelegate: AnyObject {}

class MovieDetailsUseCase {
    // MARK: - Private properties -

    // MARK: - Public properties -

    var repository: MoviesRepositoryProtocol?
    weak var delegate: MovieDetailsUseCaseResponseDelegate?

    // MARK: - Init -

    init(repository: MoviesRepositoryProtocol? = nil, delegate: MovieDetailsUseCaseResponseDelegate? = nil) {
        if repository != nil {
            self.repository = repository!
        } else {
            self.repository = MoviesRepository(delegate: self)
        }

        self.delegate = delegate
    }
}

// MARK: - Extensions -

extension MovieDetailsUseCase: MovieDetailsUseCaseProtocol {}

extension MovieDetailsUseCase: MoviesRepositoryResponseDelegate {}
