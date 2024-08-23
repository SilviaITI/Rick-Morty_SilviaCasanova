//
//  CharacterCell.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 22/8/24.
//

import SwiftUI

struct CharacterCell: View {
    
    // MARK: - Properties -
    let data: Character
    
    // MARK: - Init -
    init(_ data: Character) {
        self.data = data
    }
    
    // MARK: - Principal View -
    var body: some View {
        
        HStack(spacing: 20) {
            AsyncImage(url: data.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                Text(data.name ?? "_")
                    .setStyle(font: .bold, size: 20)
                    .multilineTextAlignment(.leading)
                Text(data.species ?? "_")
                        .setStyle(font: .regular, size: 18)
            }
            
            Spacer()
            Image(data.statusImage.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
         
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 120)
        .padding(.horizontal)
        .shadowContainer(radius: 12, backGroundColor: .blueMain, borderColor: .greenSecondary)
    }
}

#Preview {
    CharacterCell( .charTest)
}
