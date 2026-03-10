//
//  NetworkError.swift
//  FYEO
//
//  Created by Harvi Jivani on 07/03/26.
//

import Foundation

enum NetworkError:Error{
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError
}
