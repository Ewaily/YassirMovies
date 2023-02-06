//
//  MoviesListPresenter.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

protocol MoviesListPresenterProtocol {
    func viewDidLoad()
}

protocol MoviesListPresenterResponseDelegate: AnyObject {}

class MoviesListPresenter {
    // MARK: - Public properties -

    var useCase: MoviesListUseCaseProtocol?

    weak var delegate: MoviesListPresenterResponseDelegate?

    // MARK: - Init -

    init(useCase: MoviesListUseCaseProtocol? = nil, delegate: MoviesListPresenterResponseDelegate? = nil) {
        if useCase != nil {
            self.useCase = useCase!
        } else {
            self.useCase = MoviesListUseCase(delegate: self)
        }

        self.delegate = delegate
    }
}

// MARK: - Extensions -

extension MoviesListPresenter: MoviesListPresenterProtocol {
    func viewDidLoad() {
        useCase?.getMovies()
    }
}

extension MoviesListPresenter: MoviesListUseCaseResponseDelegate {
    func getMoviesSuccess(movies: Movies) {}

    func getMoviesFailed(error: NetworkError) {}
}
