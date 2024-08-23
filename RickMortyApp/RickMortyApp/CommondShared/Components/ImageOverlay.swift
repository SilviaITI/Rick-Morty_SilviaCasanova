//
//  ImageOverlay.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 23/8/24.
//

import SwiftUI

struct ImageOverlayData {
    let id: Int
    let image: Image
}

struct ImageOverlay: View {
    
    // MARK: - Properties
    let namespace: Namespace.ID
    let imageData: ImageOverlayData
    
    @Binding var isPresented: Bool
    
    // MARK: - Principal View
    var body: some View {
        
        imageData.image
            .resizable()
            .scaledToFit()
            .matchedGeometryEffect(id: imageData.id.hashValue, in: namespace)
            .shadowContainer(radius: 8)
            .padding()
            .onTapGesture {
                isPresented = false
            }
            .darkBackground($isPresented)
            .overlay(alignment: .topTrailing) {
                closeButton
            }
    }
    
    // MARK: - View Components
    private var closeButton: some View {
        Button(role: .destructive) {
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(.white)
                .padding()
        }
    }
}

