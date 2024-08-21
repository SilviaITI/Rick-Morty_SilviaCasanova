//
//  Text+extension.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

public enum SystemFont: String {
    case light
    case regular
    case semibold
    case bold
    case italic
    
    var weight: Font.Weight {
        switch self {
        case .light: return .light
        case .regular: return .regular
        case .semibold: return .semibold
        case .bold: return .bold
        case .italic: return .regular 
        }
    }
    
    var isItalic: Bool {
        switch self {
        case .italic:
            return true
        default:
            return false
        }
    }
}
extension Text {
    /// Método para configurar el texto con una fuente, un tamaño y un color
    /// - Parameters:
    ///   - font: Tipo de fuente del sistema
    ///   - size: Tamaño de la fuente de tipo CGFloat
    ///   - color: Color del texto
    /// - Returns: Devolverá el texto seteado
    func setStyle(font: SystemFont, size: CGFloat, color: Color = .black) -> Text {
        let adjustedSize = size
        var customFont = Font.system(size: adjustedSize, weight: font.weight)
        if font.isItalic {
            customFont = customFont.italic()
        }
        
        return self
            .font(customFont)
            .foregroundColor(color)
    }
}
