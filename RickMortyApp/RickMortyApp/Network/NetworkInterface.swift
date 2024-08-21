//
//  NetworkInterface.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import Foundation

struct EmptyResponse: Codable {}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkInterface {
    case getAllCharacters
    case getSingleCharacter(id: Int)

}

