//
//  MoviesRequests.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

enum MoviesRequests: RequestModel {
    case listMovies
    case movieDetails(movieId: Int)

    var method: RequestMethod {
        switch self {
        case .listMovies:
            return .get
            
        case .movieDetails:
            return .get
        }
    }

    var path: String {
        switch self {
        case .listMovies:
            return EndPoints.LIST_MOVIES
            
        case .movieDetails(let movieId):
            return "\(EndPoints.MOVIE_DETAILS)/\(movieId)"
        }
    }

    var headers: [String: String]? {
        switch self {
        case .listMovies:
            return nil
            
        case .movieDetails:
            return nil
        }
    }

    var paramters: [String: Any]? {
        switch self {
        case .listMovies:
            return [ParamterKeys.API_KEY: NetworkConstants.API_KEY_VALUE]
            
        case .movieDetails:
            return [ParamterKeys.API_KEY: NetworkConstants.API_KEY_VALUE]
        }
    }

    var requestBodyParemeters: [String: Any]? {
        switch self {
        case .listMovies:
            return nil
            
        case .movieDetails:
            return nil
        }
    }
}
