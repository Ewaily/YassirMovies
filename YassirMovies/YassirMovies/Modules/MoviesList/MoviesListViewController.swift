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
    
    // MARK: - Private properties -
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - IBOutlets -
    
    @IBOutlet private var moviesListTableView: UITableView!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupViews()
        setupLayouts()
        setupTableView()
    }
    
    private func setupViews() {
        self.view.addSubview(indicatorView)
        self.navigationItem.title = Strings.MOVIES_LIST
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        let moviesListCelll = UINib(nibName: NibNames.MOVIESLISTTABLEVIEWCELL.rawValue, bundle: nil)
        moviesListTableView.rowHeight = UITableView.automaticDimension
        moviesListTableView.separatorStyle = .none
        moviesListTableView.register(moviesListCelll, forCellReuseIdentifier: NibNames.MOVIESLISTTABLEVIEWCELL.rawValue)
        moviesListTableView.delegate = self
        moviesListTableView.dataSource = self
    }
}

extension MoviesListViewController: MoviesListPresenterResponseDelegate {
    func navigateToMovieDetailsScreen(movie: Result) {
        let viewController = MovieDetailsViewController(nibName: Storyboards.MOVIESDETAILSVIEWCONTROLLER.rawValue, bundle: nil)
        let presenter = MovieDetailsPresenter(delegate: viewController, movie: movie)
        viewController.presenter = presenter
        if let navigator = navigationController {
            navigator.pushViewController(viewController, animated: true)
        }
    }
    
    func showIndicatorView() {
        DispatchQueue.main.async {
            self.indicatorView.startAnimating()
        }
    }
    
    func hideIndicatorView() {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: Strings.ERROR, message: Strings.FAILED_TO_GET_YOUR_RESPONSE, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.TRY_AGAIN, style: UIAlertAction.Style.default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.presenter.viewDidLoad()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func loadTableView() {
        DispatchQueue.main.async {
            self.moviesListTableView.reloadData()
        }
    }
}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(index: indexPath.row)
    }
}

extension MoviesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getSectionRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: NibNames.MOVIESLISTTABLEVIEWCELL.rawValue,
            for: indexPath
        ) as? MoviesListTableViewCell {
            cell.setupCell(presenter.getMoviesListTableViewCellModel(index: indexPath.row))
            return cell
        }
        
        return UITableViewCell()
    }
}
