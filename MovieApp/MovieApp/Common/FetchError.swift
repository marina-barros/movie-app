//
//  FetchError.swift
//  MovieApp
//
//  Created by Marina Barros on 21/01/24.
//

enum FetchError: Error {
    case invalidURL
    case invalidJSONData
    case decodingError(error: String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "URL Inválido"
        case .invalidJSONData:
            return "Problema na decodificação"
        default:
            return "Algo de errado aconteceu aqui. Tente novamente mais tarde."
        }
    }
}
