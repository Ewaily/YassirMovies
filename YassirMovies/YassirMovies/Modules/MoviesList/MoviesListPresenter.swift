//
//  MoviesListPresenter.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

protocol MoviesListPresenterProtocol {
    func viewDidLoad()
    func getSectionRows() -> Int
    func getMoviesListTableViewCellModel(index: Int) -> MoviesListTableViewCellModel
    func didSelectRow(index: Int)
}

protocol MoviesListPresenterResponseDelegate: AnyObject {
    func showIndicatorView()
    func hideIndicatorView()
    func showErrorAlert()
    func loadTableView()
    func navigateToMovieDetailsScreen(movieId: Int)
}

class MoviesListPresenter {
    // MARK: - Public properties -

    var useCase: MoviesListUseCaseProtocol?
    weak var delegate: MoviesListPresenterResponseDelegate?

    // MARK: - Private properties -

    var moviesList: [Result]?
    
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
    func didSelectRow(index: Int) {
        guard let moviesList = moviesList, !moviesList.isEmpty else { return }
        delegate?.navigateToMovieDetailsScreen(movieId: moviesList[index].id)
    }
    
    func getMoviesListTableViewCellModel(index: Int) -> MoviesListTableViewCellModel {
        guard let moviesList = moviesList else { return .init(title: "", releaseDate: "", imageURL: "") }

        let model = MoviesListTableViewCellModel(title: moviesList[index].originalTitle, releaseDate: moviesList[index].releaseDate, imageURL: moviesList[index].posterPath)
        return model
    }
    
    func getSectionRows() -> Int {
        guard let moviesList = moviesList else { return 0 }
        return moviesList.count
    }
    
    func viewDidLoad() {
        delegate?.showIndicatorView()
        useCase?.getMovies()
    }
}

extension MoviesListPresenter: MoviesListUseCaseResponseDelegate {
    func getMoviesSuccess(movies: Movies) {
        delegate?.hideIndicatorView()
        self.moviesList = movies.results
        delegate?.loadTableView()
    }

    func getMoviesFailed(error: NetworkError) {
        delegate?.hideIndicatorView()
        delegate?.showErrorAlert()
    }
}
