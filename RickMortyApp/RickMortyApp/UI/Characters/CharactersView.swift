//
//  CharactersView.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

struct CharactersView: View {
    
    var body: some View {
      
                HStack(spacing: 20) {
                    Image(.rickTest)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text("Ricky García")
                            .setStyle(font: .bold, size: 20)
                            Text("Human")
                                .setStyle(font: .regular, size: 18)
                    }
                    
                    Spacer()
                    Image(.imgAlive)
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
    CharactersView()
}
