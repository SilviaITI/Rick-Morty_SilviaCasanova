//
//  DarkBackgroud.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 23/8/24.
//

import SwiftUI


struct DarkBackgroundModifier: ViewModifier {
    
    // MARK: - Properties
    @Binding var isPresented: Bool
    let backgroundColor: Color
    
    // MARK: - Init
    init(isPresented: Binding<Bool>, backgroundColor: Color = .black.opacity(0.3)) {
        self._isPresented = isPresented
        self.backgroundColor = backgroundColor
    }
    
    // MARK: - Principal View
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(backgroundColor)
                .ignoresSafeArea(edges: .bottom)
                .opacity(isPresented ? 1 : 0)
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }
            content
        }
    }
}

// MARK: - View Modifier

extension View {
    public func darkBackground(_ isPresented: Binding<Bool>,
                               backgroundColor: Color = .teal) -> some View {
        modifier(DarkBackgroundModifier(isPresented: isPresented, backgroundColor: .black.opacity(0.3)))
    }
}

