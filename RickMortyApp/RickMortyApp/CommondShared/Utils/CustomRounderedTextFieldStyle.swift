//
//  CustomRounderedTextFieldStyle.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import SwiftUI

struct CustomRounderedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .shadowContainer(radius: 8)
    }
}
