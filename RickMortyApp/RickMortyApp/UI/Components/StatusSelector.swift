//
//  StatusSelector.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import SwiftUI

struct StatusSelector: View {
    @State var selectedOption: String = StatusState.alive.rawValue
    let action: () -> ()
    var body: some View {
        HStack(spacing: 40){
            Button {
                action()
            } label: {
                Image(.imgAlive)
            }
            Button {
                action()
            } label: {
                Image(.imgDead)
            }
            Button {
                action()
            } label: {
                Image(.imgUnknownStatus)
            }
        }
    }
    
}
#Preview {
    StatusSelector( action: {})
}
