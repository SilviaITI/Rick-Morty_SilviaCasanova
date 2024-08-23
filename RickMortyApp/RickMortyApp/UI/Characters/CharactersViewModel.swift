//
//  CharactersViewModel.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import Foundation

@MainActor
final class CharactersViewModel: ObservableObject {
    
    // MARK: - Properties -
    @Published var filteredList: [Character] = []
    @Published var characterList: [Character] = []
    @Published var searchText = ""
    @Published var alertText = ""
    @Published var isFiltered = false
    @Published var originalList: [Character] = []
    @Published var selectedOption: Int = 0
    @Published var status: StatusState = .none
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var scrollToTop = false
    
    var isPaginable = true
    var currentPage = 0
    var currentFilteredPage = 0
    var enableSearchButton: Bool {
        !searchText.isEmpty || status != .none 
    }
  
    
    // MARK: - Init -
    /// Contiene el método que se ejecutará cuando aparezca la vista
    init() {
        Task { [weak self] in
            await self?.fetchCharacters()
        }
    }
   
    // MARK: - Public Methods -
    /// Método para filtrar un listado u otro
    /// Maneja el paginado tanto del listado completo como del filtrado
    /// - Parameter index: índice de next page
    func handlePage(index: Int) {
        if index == characterList.count - 3 {
            Task { [weak self] in
                if  !(self?.isFiltered ?? false) {
                    await self?.fetchCharacters()
                } else {
                    await self?.fetchCharactersFiltered()
                }
            }
        }
    }
    
    /// Método para filtrar el listado original
    func filterCharacters() {
        Task { [weak self] in
            self?.filteredList.removeAll(keepingCapacity: true)
            self?.scrollToTop = true
            await self?.fetchCharactersFiltered()
        }
    }
    
    /// Método para limpiar todos los filtros y vuelve a presentar el array original
    func clearFilters() {
        characterList = originalList
        filteredList.removeAll(keepingCapacity: true)
        searchText = ""
        isFiltered = false
        status = .none
        scrollToTop = true
    }
    
    // MARK: - API Methods -
    /// Método para traer el listado de todos los personajes y comprueba si existe una página siguiente para mostrarla
    func fetchCharacters() async {
        guard isPaginable  else { return }
        isLoading = true
        do {
            let response = try await CharactersServices.fetchCharacters(page: currentPage)
            isPaginable = response.info?.next != nil
            characterList.append(contentsOf: response.results ?? [])
            originalList = characterList
            currentPage += 1
            isFiltered = false
            
        } catch(let error) {
            if let apiError = error as? APIErrors {
                alertText = apiError.description
                showAlert = true
            }
        }
        isLoading = false
    }
    
 
    /// Método para traer el listado de los personajes filtrado opcionalmente por nombre y estado y comprueba si existe una página siguiente para mostrarla.
    func fetchCharactersFiltered() async {
        isLoading = true
        do {
            let response = try await CharactersServices.fetchCharactersByName(
                page: currentFilteredPage,
                name: searchText,
                status: status.rawValue)
            filteredList.append(contentsOf: response.results ?? [])
            characterList = filteredList
            currentFilteredPage += 1
            isFiltered = true
            
        } catch(let error) {
            if let apiError = error as? APIErrors {
                alertText = apiError.description
                showAlert = true
            }
        }
        isLoading = false
    }
}
