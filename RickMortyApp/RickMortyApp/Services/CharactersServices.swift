//
//  CharactersServices.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import Foundation

struct CharactersServices {
    static func fetchCharacters(page: Int) async throws -> ApiResponse {
        try await NetworkInterface.getAllCharacters(page: page).response()
        
    }
    
    static func fetchCharactersByName(page: Int, name: String, status: String) async throws -> ApiResponse {
        try await NetworkInterface.getCharactersFiltered(page: page, name: name, status: status).response()
    }
}
