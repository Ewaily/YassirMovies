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
    
    // MARK: - Private properties -
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var blockerView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - IBOutlets -
    
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieReleaseDateLabel: UILabel!
    @IBOutlet private weak var movieOverViewLabel: UILabel!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndicatorView()
        presenter.viewDidLoad()
    }
    
    private func setupIndicatorView() {
        self.view.addSubview(blockerView)
        self.view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

extension MovieDetailsViewController: MovieDetailsPresenterResponseDelegate {
    func showIndicatorView() {
        DispatchQueue.main.async {
            self.blockerView.isHidden = false
            self.indicatorView.startAnimating()
        }
    }
    
    func hideIndicatorView() {
        DispatchQueue.main.async {
            self.blockerView.isHidden = true
            self.indicatorView.stopAnimating()
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: Strings.ERROR, message: Strings.FAILED_TO_GET_YOUR_RESPONSE, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.TRY_AGAIN, style: UIAlertAction.Style.default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.presenter.viewDidLoad()
        }))
        alert.addAction(UIAlertAction(title: Strings.CANCEL, style: UIAlertAction.Style.cancel, handler: { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func loadViews() {
        DispatchQueue.main.async {
            self.navigationItem.title = self.presenter.getMovieTitle()
            self.movieTitleLabel.text = self.presenter.getMovieTitle()
            self.movieReleaseDateLabel.text = self.presenter.getMovieReleaseDate()
            self.movieOverViewLabel.text = self.presenter.getMovieOverView()
            guard let imageURL = self.presenter.getMoviePosterURL() else {
                self.moviePosterImageView.image = UIImage(named: Images.PLACEHOLDER)
                return
            }
            self.moviePosterImageView.load(url: imageURL)
        }
    }
}
