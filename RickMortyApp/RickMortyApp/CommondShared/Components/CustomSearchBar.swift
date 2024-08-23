//
//  CustomSearchBar.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import SwiftUI

struct CustomSearchBar: View {
    
    // MARK: - Properties -
    @Binding var searchText: String
    @FocusState var focusedField: Bool
    let isSearchEnable: Bool
    let action: () -> ()
    
    // MARK: - Principal View -
    var body: some View {
        HStack {
            TextField("search.character_textfield".localized, text: $searchText)
                .textFieldStyle(CustomRounderedTextFieldStyle())
                .focused($focusedField)
            
            Button {
                action()
            } label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.greenSecondary)
                    .opacity(isSearchEnable ? 1 : 0.6 )
                    .frame(width: 40, height: 40)
            }
            .disabled(!isSearchEnable)
            
        }
        .padding()
        .background(Color.blueMain)
    }
}

#Preview {
    CustomSearchBar(searchText: .constant(""), isSearchEnable: true, action: {})
}
