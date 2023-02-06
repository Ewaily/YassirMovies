//
//  MoviesListViewController.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import UIKit

class MoviesListViewController: UIViewController {
    // MARK: - Public properties -
    var presenter: MoviesListPresenterProtocol!

    // MARK: - IBOutlets -
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension MoviesListViewController: MoviesListPresenterResponseDelegate {
    
}
