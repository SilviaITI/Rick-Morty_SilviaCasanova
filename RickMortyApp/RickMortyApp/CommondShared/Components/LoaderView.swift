//
//  LoaderView.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 23/8/24.
//

import SwiftUI

struct LoaderView<Content: View>: View {
    
    // MARK: - Properties -
    @Binding var isLoading: Bool
    
    var content: () -> Content
    
    // MARK: - Principal View -
    var body: some View {
        ZStack {
            content()
                .blur(radius: isLoading ? 3 : 0)
            if isLoading {
                VStack(spacing: 8) {
                    ProgressView()
                        .tint(.white)
                        .padding(30)
                        .scaleEffect(2)
                        .background(Color.greenSecondary)
                }
                .shadowContainer(radius: 8)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    LoaderView(isLoading: .constant(true)) { EmptyView() }
}
