//
//  FeaturedMoviesViewModel.swift
//  MovieApp
//
//  Created by Marina Barros on 17/01/24.
//

import Foundation

protocol FeaturedMoviesViewModelDelegate: AnyObject {
    func displayPopularMoviesError(message: String)
}

final class FeaturedMoviesViewModel {
    
    var successPopularMoviesFetch: (() -> Void)?
    var failedPopularMoviesFetch: ((String) -> Void)?
    var successNowPlayingMoviesFetch: (() -> Void)?
    var failedNowPlayingMoviesFetch: ((String) -> Void)?
    var successSearchMoviesFetch: (() -> Void)?
    var failedSearchMoviesFetch: ((String) -> Void)?
    
    weak var service: FeaturedMoviesServiceProtocol?
    private var popularMovies: [Movie]?
    private var nowPlayingMovies: [Movie]?
    
    init(service: FeaturedMoviesServiceProtocol = FeaturedMoviesService()) {
        self.service = service
        getPopularMovies()
        getNowPlayingMovies()
    }
    
    func getPopularMovies() {
        guard let service = service else { return }
        service.fetchPopularMovies(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                self.popularMovies = movies
                self.successPopularMoviesFetch?()
            case .failure(let erro):
                self.failedPopularMoviesFetch?(erro.localizedDescription)
            }
        })
    }
    
    func getNowPlayingMovies() {
        guard let service = service else { return }
        service.fetchNowPlayingMovies(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                self.nowPlayingMovies = movies
                self.successNowPlayingMoviesFetch?()
            case .failure(let erro):
                self.failedNowPlayingMoviesFetch?(erro.localizedDescription)
            }
        })
    }
    
    func getNumberPopularMovies() -> Int {
        popularMovies?.count ?? 0
    }

    func getNumberNowPlayingMovies() -> Int {
        nowPlayingMovies?.count ?? 0
    }
    
    private func getMovieFromIndex(_ index: Int, isPopular: Bool) -> Movie? {
        if isPopular {
            guard let popularMovies = popularMovies else { return nil }
            return popularMovies[index]
        } else {
            guard let nowPlayingMovies = nowPlayingMovies else { return nil }
            return nowPlayingMovies[index]
        }
    }
    
    func getMovieTitle(from index: Int, isPopular: Bool) -> String? {
        let movie = getMovieFromIndex(index, isPopular: isPopular)
        return movie?.title
    }

    func getMoviePosterPath(from index: Int, isPopular: Bool) -> String? {
        let movie = getMovieFromIndex(index, isPopular: isPopular)
        return isPopular ? movie?.backdropPath : movie?.posterPath
    }
    
    func getMovieRating(from index: Int) -> String? {
        let movie = getMovieFromIndex(index, isPopular: false)
        guard let rating = movie?.voteAverage else {
            return nil
        }
        return String(format: "%.1f", rating)
    }
    
    func getMovieDetail(from index: Int, isPopular: Bool) -> MovieDetailDTO? {
        guard let movie = getMovieFromIndex(index, isPopular: isPopular) else { return nil }
        return MovieDetailDTO(title: movie.title,
                           posterPath: movie.posterPath ?? "",
                           backdropPath: movie.backdropPath ?? "",
                              rating: movie.voteAverage,
                           overview: movie.overview ?? "")
    }
}
