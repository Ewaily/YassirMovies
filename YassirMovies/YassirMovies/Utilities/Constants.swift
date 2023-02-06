//
//  Constants.swift
//  YassirMovies
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

enum Storyboards : String {
    case MOVIESDETAILSVIEWCONTROLLER = "MovieDetailsViewController"
}

enum NibNames : String {
    case MOVIESLISTTABLEVIEWCELL = "MoviesListTableViewCell"
}

struct Strings {
    static let MOVIES_LIST = "Movies List"
    static let ERROR = "Error"
    static let FAILED_TO_GET_YOUR_RESPONSE = "Failed to get your response!"
    static let TRY_AGAIN = "Try again"
}

struct EndPoints {
    static let LIST_MOVIES = "https://api.themoviedb.org/3/discover/movie"
}

struct ParamterKeys {
    static let API_KEY = "api_key"
}

struct NetworkConstants {
    static let API_KEY_VALUE = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    static let IMAGE_BASE_PATH = "https://image.tmdb.org/t/p/w500"
}

struct Images {
    static let PLACEHOLDER = "img_placeholder"
}
