//
//  DetailCharacter.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

struct DetailCharacterView: View {
    
    // MARK: - Properties -
    @ObservedObject var viewModel = DetailCharacterViewModel()
    @Namespace var namespace
    @State var showOverlayImage = false
    @State private var selectedImage: ImageOverlayData?
    let data: Character
    
    
    // MARK: - Principal View -
    var body: some View {
        
        ZStack {
            Color.blueMain
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (spacing: 16) {
                        characterImage
                    
                    Text(data.name ?? "")
                        .setStyle(font: .bold, size: 30)
                    Text("\(data.species ?? "") - \(data.origin?.name ?? "")")
                    
                        genderImage
                    
                    Text("Last known location")
                        .setStyle(font: .bold, size: 20)
                    Text(data.location?.name ?? "")
                        .setStyle(font: .regular, size: 18)
                    Text("Primer episodio")
                        .setStyle(font: .bold, size: 20)
                    Text(viewModel.episodeName)
                    
                }
            }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadowContainer(radius: 12, backGroundColor: .white.opacity(0.6), borderColor: .greenSecondary)
                .padding(24)
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
    
    @ViewBuilder
    var genderImage: some View {
        
        Image(data.genderState.image)
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
    }
}

#Preview {
    DetailCharacterView(data: .charTest)
}
