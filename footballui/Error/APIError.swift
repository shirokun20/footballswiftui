//
//  APIError.swift
//  footballui
//
//  Created by macbook on 26/09/23.
//

import Foundation


enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}
