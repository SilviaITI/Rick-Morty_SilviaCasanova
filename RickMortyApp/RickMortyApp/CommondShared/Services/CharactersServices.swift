//
//  CharactersServices.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import Foundation

struct CharactersServices {
    /// Método que hará la llamada la networkInterface para obtener la lista de los personjes con paginado
    /// - Returns: Objeto ApiResponse que contiene un objeto Info para el paginado y un objeto Results que es un array de personajes
    static func fetchCharacters(page: Int) async throws -> ApiResponse {
        try await NetworkInterface.getAllCharacters(page: page).response()
        
    }
    
    /// Método que hará la llamada la networkInterface para obtener la lista de los personjes con paginado, que opcionalmente filtre por nombre y status
    /// - Returns: Objeto ApiResponse que contiene un objeto Info para el paginado y un objeto Results que es un array de personajes
    static func fetchCharactersByName(page: Int, name: String, status: String) async throws -> ApiResponse {
        try await NetworkInterface.getCharactersFiltered(page: page, name: name, status: status).response()
    }
}
