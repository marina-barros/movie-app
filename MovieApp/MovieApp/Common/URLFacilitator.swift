//
//  URLFacilitator.swift
//  MovieApp
//
//  Created by Marina Barros on 21/01/24.
//

import Foundation

final class URLImageHelper {
    
    static let shared = URLImageHelper()
    
    func getURLFromImagePath(_ path: String) -> URL? {
        let linkPoster = "https://image.tmdb.org/t/p/w780" + path
        return URL(string: linkPoster)
    }
}
