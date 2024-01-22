//
//  Movie.swift
//  MovieApp
//
//  Created by Marina Barros on 16/01/24.
//

struct Movie: Codable {
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Float
    let releaseDate: String?
    let overview: String?
    let genres: [String]?
}
