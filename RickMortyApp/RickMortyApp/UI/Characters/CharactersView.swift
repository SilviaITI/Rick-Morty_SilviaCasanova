//
//  CharactersView.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

struct CharactersView: View {
    
    @State var searcheText = "Nombre del personaje..."
    @FocusState var isFocused
    @StateObject var viewModel = CharactersViewModel()
    @State var scrollToTop = false
    @State var showButton = false
    
    var body: some View {
        ZStack{
          
            VStack {
                CustomSearchBar(searchText: $searcheText, focusedField: _isFocused) {
                }
              
                ScrollViewReader { reader in
                    ScrollView {
                            LazyVStack(spacing: 20
                            ) {
                                ForEach(viewModel.characterList.indices, id: \.self) { index in
                                    CharacterCell(viewModel.characterList[index])
                                        .onAppear {
                                            viewModel.handlePage(index: index)
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                    .onChange(of: scrollToTop) { _ in
                        withAnimation {
                            reader.scrollTo(0, anchor: .top)
                            scrollToTop = false
                        }
                    }
                }
            }
            Button {
                    scrollToTop = true
                
            } label: {
                
               Image(systemName: "arrow.up")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundStyle(.greenSecondary)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                   
                    
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(24)

        }
    }
}



#Preview {
    CharactersView()
}
