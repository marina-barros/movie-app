//
//  MovieResults.swift
//  MovieApp
//
//  Created by Marina Barros on 21/01/24.
//

struct MovieResponse: Codable {
    let results: [Movie]?
    let page: Int?
    let total_pages: Int?
    let total_results: Int?
}
