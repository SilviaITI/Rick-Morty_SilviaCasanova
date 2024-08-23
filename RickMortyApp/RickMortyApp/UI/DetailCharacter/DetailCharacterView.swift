//
//  DetailCharacter.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

struct DetailCharacterView: View {
    
    // MARK: - Properties -
    @ObservedObject private var viewModel = DetailCharacterViewModel()
    @Namespace private var namespace
    @State private var showOverlayImage = false
    @State private var selectedImage: ImageOverlayData?
    let data: Character
    
    // MARK: - Principal View -
    var body: some View {
        
        ZStack {
            Color.blueMain
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                characterCard
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .shadowContainer(radius: 12, backGroundColor: .white.opacity(0.6), borderColor: .greenSecondary)
            .padding(30)
            
            if let selectedImage, showOverlayImage {
                ImageOverlay(namespace: namespace,
                             imageData: selectedImage,
                             isPresented: $showOverlayImage)
            }
        }
        .animation(.default, value: showOverlayImage)
        .onAppear {
            Task {
                await viewModel.fetchFirstEpisode(id: data.episode?.first?.getLastPath)
            }
        }
    }
    
    // MARK: - View Components -
    @ViewBuilder
    var characterCard: some View {
        
        VStack (spacing: 16) {
            characterImage
            
            Text(data.name ?? "")
                .setStyle(font: .bold, size: 30)
            
            Text(String(format: "detail.species_name".localized,
                        data.species ?? "", data.origin?.name ?? ""))
                .setStyle(font: .regular, size: 18)
            
            Image(data.genderState.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            Text("detail.last_known_location".localized)
                .setStyle(font: .bold, size: 20)
            
            Text(data.location?.name ?? "")
                .setStyle(font: .regular, size: 18)
            
            Text("detail.first_episode".localized)
                .setStyle(font: .bold, size: 20)
            
            Text(viewModel.episodeName)
                .setStyle(font: .regular, size: 18)
        }
    }
    
    @ViewBuilder
    var characterImage : some View {
        
        AsyncImage(url: data.image) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .cornerRadius(12)
                .matchedGeometryEffect(id: data.id,
                                       in: namespace,
                                       isSource: !showOverlayImage)
                .onTapGesture {
                    selectedImage = ImageOverlayData(id: data.id ?? 0, image: image)
                    showOverlayImage = true
                }
        } placeholder: {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .cornerRadius(12)
        }
    }
    
}

#Preview {
    DetailCharacterView(data: .charTest)
}
