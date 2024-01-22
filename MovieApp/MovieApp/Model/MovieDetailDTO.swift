//
//  MovieDetailDTO.swift
//  MovieApp
//
//  Created by Marina Barros on 19/01/24.
//

struct MovieDetailDTO: Codable, Equatable {
    let title: String
    let posterPath: String
    let backdropPath: String
    let rating: Float
    let overview: String
}
