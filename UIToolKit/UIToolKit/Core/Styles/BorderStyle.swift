//
//  BorderStyle.swift
//  StyleKit
//

import UIKit

public struct BorderStyle {
    
    public let color: UIColor
    public let thickness: CGFloat
    
    /// Returns a `BorderStyle` instance.
    ///
    /// - Parameters:
    ///   - color: Color for the border.
    ///   - thickness: Thickness for the border.
    public init(color: UIColor, thickness: CGFloat) {
        self.color = color
        self.thickness = thickness
    }
}
