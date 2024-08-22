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
    
    static func fetchCharactersByName(page: Int, name: String) async throws -> ApiResponse {
        try await NetworkInterface.getCharacterByName(page: page, name: name).response()
    }
}
