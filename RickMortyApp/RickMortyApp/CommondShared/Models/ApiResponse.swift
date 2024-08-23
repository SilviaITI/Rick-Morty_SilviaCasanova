//
//  ApiResponse.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import Foundation

struct ApiResponse: Codable {
    
    let info: Info?
    let results: [Character]?
}
