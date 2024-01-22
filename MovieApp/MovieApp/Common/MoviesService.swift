//
//  MoviesService.swift
//  MovieApp
//
//  Created by Marina Barros on 21/01/24.
//

import Foundation

class MoviesService {
    lazy var urlComponents: URLComponents? = {
        var components = URLComponents(string: "https://api.themoviedb.org/")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: MoviesService.apiKey),
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "include_adult", value: "false")
        ]
        return components
    }()
    
    static let imageURL = "https://image.tmdb.org/t/p/w780"
    let session = URLSession.shared

    static var apiKey: String {
        guard let url = Bundle.main.url(forResource: "TMDB-Info", withExtension: "plist") else {
            fatalError("Couldn't find api key configuration file.")
        }
        guard let plist = try? NSDictionary(contentsOf: url, error: ()) else {
            fatalError("Couldn't interpret api key configuration file as plist.")
        }
        guard let key = plist["API_KEY"] as? String else {
            fatalError("Couldn't find an api key in its configuration file.")
        }
        return key
    }
}
