//
//  CharactersView.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

struct CharactersView: View {
    
    // MARK: - Properties -
    @StateObject var viewModel = CharactersViewModel()
    @State var scrollToTop = false
    @State var showButton = false
    @State var isFiltered = false
    
    
    // MARK: - Principal View -
    var body: some View {
        
        LoaderView(isLoading: $viewModel.isLoading) {
            
            VStack {
                simpleAlertContent
                CustomSearchBar(searchText: $viewModel.searchText, isSearchEnable: viewModel.enableSearchButton) {
                    viewModel.filterCharacters()
                }
                
                StatusSelector(status: $viewModel.status)
                if viewModel.isFiltered {
                    clearFilterButton
                }
                
                ScrollViewReader { reader in
                    ScrollView {
                        LazyVStack(spacing: 16
                        ) {
                            ForEach(viewModel.characterList.indices, id: \.self) { index in
                                NavigationLink {
                                    DetailCharacterView(data: viewModel.characterList[index])
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
            .animation(.default, value: viewModel.isFiltered)
            .overlay(alignment: .bottomTrailing) {
                scrollTopButton
            }
            
            
        }
    }
    
    
    // MARK: - View Components -
    @ViewBuilder
    var simpleAlertContent: some View {
        ZStack {}
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Error al descargar los datos."),
                    dismissButton: .default(Text("Aceptar"))
                )
            }
    }
    
    @ViewBuilder
    var clearFilterButton: some View {
        Button {
            viewModel.clearFilters()
        } label: {
            Label(
                title: { Text("Limpiar filtros")
                    
                        .setStyle(font: .regular, size: 12, color: .black)
                    
                },
                icon: { Image(systemName: "xmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red.opacity(0.6))
                        .frame(width: 24, height: 24)
                }
            )
            .padding(4)
            .shadowContainer(borderColor: .red.opacity(0.6))
            .padding(8)
            
        }
    }
    
    @ViewBuilder
    var scrollTopButton: some View {
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
        .padding(24)
    }
}


#Preview {
    CharactersView()
}
