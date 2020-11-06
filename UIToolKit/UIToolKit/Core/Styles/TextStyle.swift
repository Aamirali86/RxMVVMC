//
//  TextStyle.swift
//  StyleKit
//

import UIKit

public struct TextStyle {
    
    public var font: Font
    public var color: UIColor
    public var alignment: NSTextAlignment
    public var lineHeightMultiple: CGFloat?
    public var maximumLineHeight: CGFloat?
    public var minimumLineHeight: CGFloat?
    
    /// Returns a `TextStyle` instance. All of the properties are optional and can be modified after
    /// initialization.
    ///
    /// - Parameters:
    ///   - font: A `Font` instance defining the font to be used.
    ///   - color: Color for text.
    ///   - lineHeight: A `CGFloat` value to define the line height for the text. `nan` means to use the
    ///   component default value.
    ///   - alignment: A `NSTextAlignment` instance defining the alignment for the text.
    public init(font: Font = Font(),
                color: UIColor = .black,
                alignment: NSTextAlignment = .natural,
                lineHeightMultiple: CGFloat? = nil,
                maximumLineHeight: CGFloat? = nil,
                minimumLineHeight: CGFloat? = nil) {
        self.font = font
        self.color = color
        self.alignment = alignment
        self.lineHeightMultiple = lineHeightMultiple
        self.maximumLineHeight = maximumLineHeight
        self.minimumLineHeight = minimumLineHeight
    }
}
