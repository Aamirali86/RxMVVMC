//
//  Font.swift
//  StyleKit
//

import UIKit

public struct Font {
    
    public var size: CGFloat
    public var weight: UIFont.Weight
    public var traits: UIFontDescriptor.SymbolicTraits
    
    var uiFont: UIFont {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        if traits.isEmpty == false {
            if let descriptor = font.fontDescriptor.withSymbolicTraits(traits) {
                return UIFont(descriptor: descriptor, size: size)
            }
        }
        return font
    }
    
    /// Returns a `Font` instance. All of the properties are optional and can be modified after
    /// initialization. Default font definition is system font of size 17 with regular font weight.
    ///
    /// - Parameters:
    ///   - size: Size for the font.
    ///   - weight: Font weight for the font.
    public init(size: CGFloat = 17.0,
                weight: UIFont.Weight = .regular,
                traits: UIFontDescriptor.SymbolicTraits = []) {
        self.size = size
        self.weight = weight
        self.traits = traits
    }
}
