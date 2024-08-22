//
//  CharactersView.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

struct CharactersView: View {
    

    @FocusState var isFocused
    @StateObject var viewModel = CharactersViewModel()
    @State var scrollToTop = false
    @State var showButton = false
    @State var isFiltered = false
    
    var body: some View {
        ZStack {
          
            VStack {
                CustomSearchBar(searchText: $viewModel.searchText, focusedField: _isFocused) {
                    viewModel.filterCharacters()
                }
                if viewModel.isFiltered {
                    Button {
                        viewModel.clearFilters()
                    } label: {
                        Label(
                            title: { Text("Limpiar filtros")
                                
                                    .setStyle(font: .regular, size: 16, color: .black)
                                   
                            },
                            icon: { Image(systemName: "xmark.square.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.red.opacity(0.6))
                                .frame(width: 40, height: 40)    
                            }
                        )
                        .padding(6)
                        .shadowContainer(borderColor: .red.opacity(0.6))
                        
                    }
                }
                ScrollViewReader { reader in
                    ScrollView {
                            LazyVStack(spacing: 16
                            ) {
                                ForEach(viewModel.characterList.indices, id: \.self) { index in
                                    NavigationLink {
                                        DetailCharacter(data: viewModel.characterList[index])
                                    } label: {
                                        CharacterCell(viewModel.characterList[index])
                                            .onAppear {
                                                viewModel.handlePage(index: index)
                                            }
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
