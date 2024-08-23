//
//  DetailCharacterViewModel.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 23/8/24.
//

import Foundation

final class DetailCharacterViewModel: ObservableObject {
    
    // MARK: - Properties -
    @Published var episodeName = ""

    
    // MARK: - API Methods -
    /// Método para traer el nombre del primer episodio donde aparece un personaje 
    @MainActor
    func fetchFirstEpisode(id: String?) async {
        guard let id, let intId = Int(id) else { return }
        
        let response = try? await EpisodeServices.fetchEpisodeById(id: intId)
        episodeName = response?.name ?? "-"
 
    }
}
