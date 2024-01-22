//
//  FeaturedMoviesView.swift
//  MovieApp
//
//  Created by Marina Barros on 17/01/24.
//

import UIKit

protocol FeaturedMoviesViewDelegate: AnyObject {
    func getNumberPopularMovies() -> Int
    func getNumberNowPlayingMovies() -> Int
}

final class FeaturedMoviesView: UIView {
    private lazy var popularLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26)
        label.textAlignment = .left
        label.text = "Populares"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 200, height: 130)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(PopularMovieCell.self, forCellWithReuseIdentifier: PopularMovieCell.identifier)
        view.backgroundView = activityPopular
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var activityPopular: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()

    private lazy var nowPlayingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26)
        label.textAlignment = .left
        label.text = "Em Cartaz"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var activityNowPlaying: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.startAnimating()
        return activity
    }()

    lazy var nowPlayingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 251, height: 114)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(NowPlayingCell.self, forCellWithReuseIdentifier: NowPlayingCell.identifier)
        view.backgroundView = activityNowPlaying
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    weak var delegate: FeaturedMoviesViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeaturedMoviesView: BaseViewCode {
    func setupSubviews() {
        addSubviews([
            popularLabel,
            popularCollectionView,
            nowPlayingLabel,
            nowPlayingCollectionView
        ])
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            popularLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            popularLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            popularLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            popularLabel.heightAnchor.constraint(equalToConstant: 30),

            popularCollectionView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor),
            popularCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            popularCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            popularCollectionView.heightAnchor.constraint(equalToConstant: 130),

            nowPlayingLabel.topAnchor.constraint(equalTo: popularCollectionView.bottomAnchor, constant: 24),
            nowPlayingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nowPlayingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nowPlayingLabel.heightAnchor.constraint(equalToConstant: 30),

            nowPlayingCollectionView.topAnchor.constraint(equalTo: nowPlayingLabel.bottomAnchor),
            nowPlayingCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            nowPlayingCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nowPlayingCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nowPlayingCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
    }

    func stopActivitiesAnimations() {
        activityPopular.stopAnimating()
        activityNowPlaying.stopAnimating()
    }
}
