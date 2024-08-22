//
//  CharactersViewModel.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import Foundation
final class CharactersViewModel: ObservableObject {
    
    @Published var filteredCharacter: Character = .charTest
    @Published var searchName: String?
    @Published var characterList: [Character] = []
    @Published var searchText = ""
    
    var isPaginable = true
    var listError = false
    var currentPage = 0
    
    init() {
        Task { [weak self] in
            await self?.fetchCharacters()
        }
    }
    func selectCharacter(_ name: String?) {
        searchName = name
    }
    func handlePage(index: Int) {
        if index == characterList.count - 3 {
            Task {
               await fetchCharacters()
            }
        }
    }
    
    func fetchCharacters() async {
        guard isPaginable  else { return }
        do {
            let response = try await CharactersServices.fetchCharacters(page: currentPage)
            isPaginable = response.info?.next != nil
            characterList.append(contentsOf: response.results ?? [])
            currentPage += 1
        } catch {
            listError = true
            
        }
    }
}
