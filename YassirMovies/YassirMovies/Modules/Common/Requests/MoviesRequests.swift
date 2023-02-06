//
//  MoviesRequests.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

enum MoviesRequests: RequestModel {
    case listMovies

    var method: RequestMethod {
        switch self {
        case .listMovies:
            return .get
        }
    }

    var path: String {
        switch self {
        case .listMovies:
            return "https://api.themoviedb.org/3/discover/movie"
        }
    }

    var headers: [String: String]? {
        switch self {
        case .listMovies:
            return nil
        }
    }

    var paramters: [String: Any]? {
        switch self {
        case .listMovies:
            return ["api_key": "c9856d0cb57c3f14bf75bdc6c063b8f3"]
        }
    }

    var requestBodyParemeters: [String: Any]? {
        switch self {
        case .listMovies:
            return nil
        }
    }
}
