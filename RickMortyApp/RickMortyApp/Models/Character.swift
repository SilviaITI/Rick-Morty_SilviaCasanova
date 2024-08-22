//
//  Character.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import Foundation

struct Character: Codable {
    
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: Origin?
    let location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    
    var statusImage: StatusState {
        StatusState(rawValue: status ?? "") ?? .unknown
    }
    
    var genderState: GenderState {
        GenderState(rawValue: gender ?? "") ?? .unknown
    }
}

enum StatusState: String {
    
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var image: String {
        switch self {
        case .alive:
            return "img_alive"
        case .dead:
            return "img_dead"
        case .unknown:
            return "img_unknown_status"
        }
    }
}

enum GenderState: String {
    
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
    
    var image: String {
        switch self {
        case .female:
            return "icn_female_gender"
        case .male:
            return "icn_male_gender"
        case .genderless:
            return "icn_genderless"
        case .unknown:
          return  "icn_unknown_gender"
        }
    }
}

extension Character {
    static let charTest = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "Person who travel the world", gender: "Male", origin: originTest, location: locationTest, image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: ["Episodeurltest"], url: "https://rickandmortyapi.com/api/character")
    
    static let originTest = Origin(name: "Earth", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9DGm9paGxvLOOcxjka6dWwZ-ViZ4aq8Hi_g&s")
    
    static let locationTest = Location(id: 1, name: "Paris", type: "City", dimension: "", residents: [], url: "Empty url", created: "06/08/2021")
}


