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

    @IBOutlet private var moviesListTableView: UITableView!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieDetailsViewController: MovieDetailsPresenterResponseDelegate {}
