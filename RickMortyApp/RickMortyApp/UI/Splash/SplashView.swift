//
//  SplashView.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

enum ViewState {
    case splash
    case characters
}

struct SplashView: View {
    
    @State private var isAnimating = false
    @State private var viewState: ViewState = .splash
    
    var body: some View {
        NavigationStack {
            switch viewState {
            case .splash:
                splashContent
            case .characters:
                CharactersView()
            }
        }
    }
    
    @ViewBuilder
    private var splashContent: some View {
        
        Image(.rmImgSplash)
            .resizable()
            .scaledToFit()
            .scaleEffect(isAnimating ? 1.0 : 0.1)
            .animation(.easeInOut(duration: 3), value: isAnimating)
            .padding()
            .onAppear(perform: startAnimation)
    }
}

// MARK: - View Extensions
extension SplashView {
    private func startAnimation() {
        withAnimation {
            isAnimating = true
        }
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
            viewState = .characters
        }
    }
}

#Preview {
    SplashView()
}
