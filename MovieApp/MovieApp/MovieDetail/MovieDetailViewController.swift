//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Marina Barros on 18/01/24.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private lazy var movieDetailView = MovieDetailView()
    
    private var viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setMovieInfo()
        configureViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func setMovieInfo() {
        movieDetailView.set(biggerPosterPath: viewModel.biggerPosterPath)
        movieDetailView.set(smallerPosterPath: viewModel.smallPosterPath)
        movieDetailView.set(title: viewModel.title)
        movieDetailView.set(rating: viewModel.formattedRating)
        movieDetailView.set(overview: viewModel.overviewDescription)
    }
}

extension MovieDetailViewController: BaseViewCode {
    func setupSubviews() {
        view.addSubview(movieDetailView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            movieDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupUI() {
        title = viewModel.title
    }
}
