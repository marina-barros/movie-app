//
//  SearchMovieService.swift
//  MovieApp
//
//  Created by Marina Barros on 20/01/24.
//

import Foundation

protocol SearchMovieServiceProtocol {
    func searchMovie(input: String, completion: @escaping (Result<[Movie], FetchError>) -> Void)
}

final class SearchMovieService: MoviesService, SearchMovieServiceProtocol {
    func searchMovie(input: String, completion: @escaping (Result<[Movie], FetchError>) -> Void) {
        var components = urlComponents
        components?.path = "/3/search/movie"
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: MoviesService.apiKey),
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "query", value: input),
            URLQueryItem(name: "page", value: "1")
        ]
        guard let searchMovieURL = components?.url else {
            completion(.failure(.invalidURL))
            return
        }

        let task = session.dataTask(with: searchMovieURL) { (data, response, error) in
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
