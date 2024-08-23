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
    
    // MARK: - Principal View -
    var body: some View {
        
        LoaderView(isLoading: $viewModel.isLoading) {
            
            VStack {
                simpleAlertContent
                
                CustomSearchBar(searchText: $viewModel.searchText,
                                isSearchEnable: viewModel.enableSearchButton) {
                    viewModel.filterCharacters()
                }
                
                StatusSelector(status: $viewModel.status)
                
                if viewModel.isFiltered {
                    clearFilterButton
                }
                
                listSection
            }
            .animation(.default, value: viewModel.isFiltered)
            .overlay(alignment: .bottomTrailing) {
                scrollTopButton
            }
        }
    }
    
    
    // MARK: - View Components -
    @ViewBuilder
    private var listSection: some View {
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
            .onChange(of: viewModel.scrollToTop) { _ in
                withAnimation {
                    reader.scrollTo(0, anchor: .top)
                    viewModel.scrollToTop = false
                }
            }
        }
    }
    @ViewBuilder
    private var simpleAlertContent: some View {
        ZStack {}
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text( "error".localized),
                    message: Text(viewModel.alertText),
                    dismissButton: .default(Text("aceptar".localized))
                )
            }
    }
    
    @ViewBuilder
    private var clearFilterButton: some View {
        Button {
            viewModel.clearFilters()
        } label: {
            Label(
                title: {
                    Text("home_clear_filters".localized)
                        .setStyle(font: .regular, size: 12, color: .black)
                },
                icon: {
                    Image(systemName: "xmark.square.fill")
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
    private var scrollTopButton: some View {
        Button {
            viewModel.scrollToTop = true
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
