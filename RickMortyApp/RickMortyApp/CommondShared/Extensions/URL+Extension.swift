//
//  URL*Extension.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 23/8/24.
//

import Foundation

extension URL {
    
    // Método para obtener la última parte del path de una url
  var getLastPath: String? {
        let lastPathComponent = self.lastPathComponent
        return lastPathComponent
    }
}
