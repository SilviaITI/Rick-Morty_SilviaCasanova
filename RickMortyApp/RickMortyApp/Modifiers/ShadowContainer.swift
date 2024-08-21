//
//  ShadowContainer.swift
//  RickMortyApp
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

struct ShadowContainer: ViewModifier {
    
    // MARK: - Properties
    let radius: Double
    let backGroundColor: Color
    let shadowColor: Color
    let borderColor: Color
    
    // MARK: - Init
    public init(radius: Double,
                backGroundColor: Color,
                shadowColor: Color,
                borderColor: Color) {
        self.radius = radius
        self.backGroundColor = backGroundColor
        self.shadowColor = shadowColor
        self.borderColor = borderColor
    }
    
    // MARK: - Principal View
    public func body(content: Content) -> some View {
        ZStack {
            content
        }
        .background(backGroundColor)
        .cornerRadius(radius)
        .shadow(color: shadowColor.opacity(0.25), radius: 6, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(borderColor, lineWidth: 2.0))
    }
}

// MARK: - View Modifier
extension View {
    public func shadowContainer(radius: Double = 3,
                                backGroundColor: Color = .white,
                                shadowColor: Color = .black,
                                borderColor: Color = .clear) -> some View {
        modifier(ShadowContainer(radius: radius,
                                 backGroundColor: backGroundColor,
                                 shadowColor: shadowColor,
                                 borderColor: borderColor))
    }
}

