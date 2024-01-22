//
//  SearchMovieViewModel.swift
//  MovieApp
//
//  Created by Marina Barros on 19/01/24.
//

import Foundation

final class SearchMovieViewModel {

    var successSearchMovies: (() -> Void)?
    var failedSearchMovies: ((String) -> Void)?

    private let movieService: SearchMovieServiceProtocol
    private var movies: [Movie]?

    init(service: SearchMovieServiceProtocol = SearchMovieService()) {
        self.movieService = service
    }

    func fetchSearchedMovies(query: String) {
        movieService.searchMovie(input: query, completion: { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let movies):
                self.movies = movies
                self.successSearchMovies?()
            case .failure(let erro):
                print(erro.localizedDescription)
                self.failedSearchMovies?(erro.localizedDescription)
            }
        })
    }
    
    var movieCount: Int {
        movies?.count ?? 0
    }
    
    func getMovieName(from index: Int) -> String? {
        guard let movies = movies else { return nil }
        return movies[index].title
    }
    
    func getMovieDetail(from index: Int) -> MovieDetailDTO? {
        guard let movie = getMovieFromIndex(index) else { return nil }
        return MovieDetailDTO(title: movie.title,
                           posterPath: movie.posterPath ?? "",
                           backdropPath: movie.backdropPath ?? "",
                              rating: movie.voteAverage,
                           overview: movie.overview ?? "")
    }
    
    private func getMovieFromIndex(_ index: Int) -> Movie? {
        guard let movies = movies else { return nil }
        return movies[index]
    }
}
