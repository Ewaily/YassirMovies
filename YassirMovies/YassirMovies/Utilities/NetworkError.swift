//
//  NetworkError.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
    case apiFailure
}
