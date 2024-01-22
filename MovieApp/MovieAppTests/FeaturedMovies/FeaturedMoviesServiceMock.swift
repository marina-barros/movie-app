//
//  FeaturedMoviesServiceMock.swift
//  MovieApp
//
//  Created by Marina Barros on 21/01/24.
//

final class FeaturedMoviesServiceMock: FeaturedMoviesServiceProtocol {
    
    var success = true

    func fetchPopularMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void) {
        if success {
            completion(.success(ListMoviesTestFactory.popularMovies))
        } else {
            completion(.failure(.decodingError(error: "Erro popular teste")))
        }
    }
                       
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void) {
        if success {
            completion(.success(ListMoviesTestFactory.nowPlayingMovies))
        } else {
            completion(.failure(.decodingError(error: "Erro now playing teste")))
        }
    }
}
