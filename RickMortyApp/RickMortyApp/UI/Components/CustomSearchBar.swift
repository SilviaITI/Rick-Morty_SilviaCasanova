//
//  CustomSearchBar.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import SwiftUI

struct CustomSearchBar: View {
    
    @Binding var searchText: String
    @FocusState var focusedField: Bool
    let action: () -> ()
    var body: some View {
      
        HStack {
            TextField("Nombre del personaje...", text: $searchText)
                .textFieldStyle(CustomRounderedTextFieldStyle())
                .focused($focusedField)
       
                Button {
                    action()
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.greenSecondary)
                        .frame(width: 40, height: 40)
                }

        }
    .padding()
    .background(Color.blueMain)
        }
    }


#Preview {
    CustomSearchBar(searchText: .constant(""), action: {})
}
