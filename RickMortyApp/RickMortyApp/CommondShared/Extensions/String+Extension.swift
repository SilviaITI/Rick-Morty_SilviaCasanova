//
//  String+Extension.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import Foundation

extension String {
    
    // Se utiliza para el control de copies
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
