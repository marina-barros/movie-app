//
//  MoviesService.swift
//  MovieApp
//
//  Created by Marina Barros on 16/01/24.
//

import Foundation

protocol FeaturedMoviesServiceProtocol: AnyObject {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void)
    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void)
}

final class FeaturedMoviesService: MoviesService, FeaturedMoviesServiceProtocol {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void) {
        urlComponents?.path = "/3/movie/popular"

        guard let popularURL = urlComponents?.url else {
            completion(.failure(.invalidURL))
            return
        }

        let task = session.dataTask(with: popularURL) { (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.invalidJSONData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(MovieResponse.self, from: jsonData)

                guard let results = decoded.results else {
                    completion(.failure(.decodingError(error: "Erro")))
                    return
                }

                completion(.success(results))
            } catch let error {
                completion(.failure(.decodingError(error: error.localizedDescription)))
            }
        }

        task.resume()
    }

    func fetchNowPlayingMovies(completion: @escaping (Result<[Movie], FetchError>) -> Void) {
        urlComponents?.path = "/3/movie/now_playing"

        guard let nowPlayingURL = urlComponents?.url else {
            completion(.failure(.invalidURL))
            return
        }

        let task = session.dataTask(with: nowPlayingURL) { (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.invalidJSONData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(MovieResponse.self, from: jsonData)

                guard let results = decoded.results else {
                    completion(.failure(.decodingError(error: "Erro")))
                    return
                }

                completion(.success(results))
            } catch let error {
                completion(.failure(.decodingError(error: error.localizedDescription)))
            }
        }

        task.resume()
    }
}
