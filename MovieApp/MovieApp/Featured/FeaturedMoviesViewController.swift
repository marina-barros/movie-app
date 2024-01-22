//
//  FeaturedMoviesViewController.swift
//  MovieApp
//
//  Created by Marina Barros on 17/01/24.
//

import UIKit

final class FeaturedMoviesViewController: UIViewController {
    private let viewModel = FeaturedMoviesViewModel()
        
    private lazy var moviesView = FeaturedMoviesView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setDelegatesAndDataSources()
        bind()
        viewModel.getPopularMovies()
        viewModel.getNowPlayingMovies()
        configureViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    func setDelegatesAndDataSources() {
        moviesView.popularCollectionView.delegate = self
        moviesView.popularCollectionView.dataSource = self
        moviesView.nowPlayingCollectionView.delegate = self
        moviesView.nowPlayingCollectionView.dataSource = self
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func bind() {
        viewModel.successPopularMoviesFetch = { [unowned self] in
            DispatchQueue.main.async {
                self.moviesView.stopActivitiesAnimations()
                self.moviesView.popularCollectionView.reloadData()
            }
        }
        
        viewModel.failedPopularMoviesFetch = { [unowned self] errorMessage in
            DispatchQueue.main.async {
                self.moviesView.stopActivitiesAnimations()
                self.showAlert(title: "Ops, ocorreu um erro.", message: errorMessage)
            }
        }

        viewModel.successNowPlayingMoviesFetch = { [unowned self] in
            DispatchQueue.main.async {
                self.moviesView.stopActivitiesAnimations()
                self.moviesView.nowPlayingCollectionView.reloadData()
            }
        }
        
        viewModel.failedNowPlayingMoviesFetch = { [unowned self] errorMessage in
            DispatchQueue.main.async {
                self.moviesView.stopActivitiesAnimations()
                self.showAlert(title: "Ops, ocorreu um erro.", message: errorMessage)
            }
        }
    }
}

extension FeaturedMoviesViewController: BaseViewCode {
    func setupSubviews() {
        view.addSubview(moviesView)
    }
    
    func setupConstraints() {
        moviesView.fill(view: self.view)
    }
    
    func setupUI() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.sizeToFit()
    }
    
    func goToMovieDetail(from movie: MovieDetailDTO) {
        let viewModelDetail = MovieDetailViewModel(movie: movie)
        let controller = MovieDetailViewController(viewModel: viewModelDetail)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension FeaturedMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviesView.popularCollectionView {
            return viewModel.getNumberPopularMovies()
        } else if collectionView == moviesView.nowPlayingCollectionView {
            return viewModel.getNumberNowPlayingMovies()
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == moviesView.popularCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCell.identifier,
                                                                for: indexPath) as? PopularMovieCell,
                  let movieTitle = viewModel.getMovieTitle(from: indexPath.row, isPopular: true),
                  let posterImagePath = viewModel.getMoviePosterPath(from: indexPath.row, isPopular: true) else {
                return UICollectionViewCell()
            }
            
            cell.setMovie(title: movieTitle, imagePath: posterImagePath)
            return cell
        } else if collectionView == moviesView.nowPlayingCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCell.identifier,
                                                                          for: indexPath) as? NowPlayingCell,
                  let movieTitle = viewModel.getMovieTitle(from: indexPath.row, isPopular: false),
                  let posterImagePath = viewModel.getMoviePosterPath(from: indexPath.row, isPopular: false),
                  let rating = viewModel.getMovieRating(from: indexPath.row)
            else {
                return UICollectionViewCell()
            }

            cell.setMovie(title: movieTitle, imagePath: posterImagePath, rating: rating)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isPopular = collectionView == moviesView.popularCollectionView
        guard let movie = viewModel.getMovieDetail(from: indexPath.row, isPopular: isPopular) else { return }
        goToMovieDetail(from: movie)
    }
}
