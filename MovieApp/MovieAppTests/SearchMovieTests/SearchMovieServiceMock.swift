//
//  SearchMovieServiceMock.swift
//  MovieApp
//
//  Created by Marina Barros on 22/01/24.
//

@testable import MovieApp

final class SearchMovieServiceMock: SearchMovieServiceProtocol {

    var success = true

    func searchMovie(input: String, completion: @escaping (Result<[Movie], FetchError>) -> Void) {
        if success {
            completion(.success(ListMoviesTestFactory.movies))
        } else {
            completion(.failure(.decodingError(error: "Erro search movies teste")))
        }
    }
}
