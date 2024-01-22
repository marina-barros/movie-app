//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Marina Barros on 19/01/24.
//

import Foundation

final class MovieDetailViewModel {
    
    private let movie: MovieDetailDTO
    
    init(movie: MovieDetailDTO) {
        self.movie = movie
    }
    
    var formattedRating: String {
        let rating =  String(format: "%.1f", movie.rating)
        return "★\(rating)/10"
    }
    
    var smallPosterPath: String {
        movie.posterPath
    }
    
    var biggerPosterPath: String {
        movie.backdropPath
    }
    
    var title: String {
        movie.title
    }
    
    var overviewDescription: String {
        movie.overview
    }
}
