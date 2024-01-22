//
//  ListMoviesTestFactory.swift
//  MovieApp
//
//  Created by Marina Barros on 21/01/24.
//

struct ListMoviesTestFactory {
    static let popularMovies = [Movie(title: "Teste 1",
                        posterPath: "/posterPathTeste1",
                        backdropPath: "/backdropPathTeste1",
                        voteAverage: 10.0,
                        releaseDate: "01/05/2020",
                        overview: "Teste, apenas um teste.",
                        genres: ["drama", "suspense"]),
                  Movie(title: "Teste 2 - O Retorno",
                        posterPath: "/posterPathTeste2",
                        backdropPath: "/backdropPathTeste2",
                        voteAverage: 8.5,
                        releaseDate: "16/01/2021",
                        overview: "Teste faz um retorno magnífico.",
                        genres: ["aventura"])]
    
    static let nowPlayingMovies = [Movie(title: "Teste 3",
                        posterPath: "/posterPathTeste3",
                        backdropPath: "/backdropPathTeste3",
                        voteAverage: 9.023,
                        releaseDate: "19/01/2024",
                        overview: "Teste versão infantil.",
                        genres: ["infantil", "aventura"]),
                  Movie(title: "Teste 4",
                        posterPath: "/posterPathTeste4",
                        backdropPath: "/backdropPathTeste4",
                        voteAverage: 6.5,
                        releaseDate: "05/01/2024",
                        overview: "Teste usa suas habilidades para sobreviver.",
                        genres: ["ação", "aventura"]),
                  Movie(title: "Teste 5",
                        posterPath: "/posterPathTeste5",
                        backdropPath: "/backdropPathTeste5",
                        voteAverage: 9.4,
                        releaseDate: "12/01/2024",
                        overview: "Teste enfrenta diversas assombrações.",
                        genres: ["terror"])]
    
    static let movies = popularMovies + nowPlayingMovies
}

