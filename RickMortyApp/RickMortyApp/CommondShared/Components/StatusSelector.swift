//
//  StatusSelector.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import SwiftUI

struct StatusSelector: View {
    
    // MARK: - Properties -
    @Binding var status: StatusState
    
    // MARK: - Principal View -
    var body: some View {
        VStack (spacing: 12) {
            Text("status.select_status".localized)
                .setStyle(font: .regular, size: 12)
            
            HStack(spacing: 30) {
                ForEach(StatusState.allCases, id: \.self) { state in
                    Button {
                        status = state
                    } label: {
                        VStack {
                            Image(state.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 60, height: 60)
                                .background(status == state ? .blueMain.opacity(0.2) : Color.clear)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(status == state ? .blueMain: Color.white, lineWidth: 2)
                                )
                            
                            Text(state.rawValue)
                                .setStyle(font: .regular, size: 12)
                                .foregroundColor(status == state ? .blue : .gray)
                        }
                    }
                    .disabled(status == state)
                }
            }
            .padding()
            .frame(height: 70)
            
        }
    }
}


#Preview {
    StatusSelector(status: .constant(.alive))
}
