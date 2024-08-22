//
//  DetailCharacter.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

struct DetailCharacter: View {
    
    let data: Character
    
    var body: some View {
        
        ZStack {
            Color.blueMain
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (spacing: 16) {
                    AsyncImage(url: data.image) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(12)
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(12)
                    }
                    
                    Text(data.name ?? "")
                        .setStyle(font: .bold, size: 30)
                    Text("\(data.species ?? "") - \(data.origin?.name ?? "")")
                    
                    Image(data.genderState.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                    
                    Text("Last known location")
                        .setStyle(font: .bold, size: 20)
                    Text(data.location?.name ?? "")
                        .setStyle(font: .regular, size: 18)
                    Text("Primer episodio")
                        .setStyle(font: .bold, size: 20)
                    Text(data.episode?.first ?? "")
                    
                }
            }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadowContainer(radius: 12, backGroundColor: .white.opacity(0.6), borderColor: .greenSecondary)
                .padding(24)
            
            
        }
      
    }
}

#Preview {
    DetailCharacter(data: .charTest)
}
