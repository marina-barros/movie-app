//
//  MovieDetailTestsHelper.swift
//  MovieApp
//
//  Created by Marina Barros on 22/01/24.
//

@testable import MovieApp

struct MovieDetailTestHelper {
    static let dto = MovieDetailDTO(title: "Teste O Filme",
                                    posterPath: "/posterPathTesteOFilme",
                                    backdropPath: "/backdropPathTesteOFilme",
                                    rating: 9.2,
                                    overview: "A vida de Teste se torna uma grande aventura")
}
