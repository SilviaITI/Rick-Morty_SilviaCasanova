//
//  DetailCharacterViewModel.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 23/8/24.
//

import Foundation

final class DetailCharacterViewModel: ObservableObject {
    
    @Published var episodeName = ""
    

    
    @MainActor
    func fetchFirstEpisode(id: Int?) async {
        guard let id else { return }
        let response = try? await EpisodeServices.fetchEpisodeById(id: id)
        episodeName = response?.name ?? "-"
 
    }
    
    
 
    
}
