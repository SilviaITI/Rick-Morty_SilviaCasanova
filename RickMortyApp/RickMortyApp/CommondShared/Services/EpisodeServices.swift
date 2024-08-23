//
//  EpisodeServices.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 23/8/24.
//

import Foundation

struct EpisodeServices {
   
    /// Método que hará la llamada la networkInterface para obtener la lista de los personjes con paginado
    /// - Returns: Objeto ApiResponse que contiene un objeto Info para el paginado y un objeto Results que es un array de personajes
    static func fetchEpisodeById(id: Int) async throws -> Episode {
        try await NetworkInterface.getEpisodeById(id: id).response()
        
    }
}
