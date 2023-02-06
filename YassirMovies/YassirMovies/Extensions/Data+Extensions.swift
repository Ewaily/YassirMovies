//
//  Data+Extensions.swift
//  IPS-Lessons
//
//  Created by Muhammad Ewaily on 06/02/2023.
//

import Foundation

extension Data {
    func decode<T: Decodable>(class: T.Type) -> Swift.Result<T, NetworkError> {
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(T.self, from: self)
            return .success(decoded)
        } catch let error {
            print("decoding error: \(error)")
            return .failure(.decodingError)
        }
    }
}
