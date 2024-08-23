//
//  URL*Extension.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 23/8/24.
//

import Foundation

extension URL {
    
    //Método para obtener el id del primer episodio de un personaje a partir del path
  var getLastPath : Int? {
        let lastPathComponent = self.lastPathComponent
        return Int(lastPathComponent)
    }
}
