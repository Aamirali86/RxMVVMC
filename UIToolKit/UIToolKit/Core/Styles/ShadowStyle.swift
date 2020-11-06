//
//  ShadowStyle.swift
//  StyleKit
//

import UIKit

public struct ShadowStyle {
    
    public let color: UIColor
    public let radius: CGFloat
    public let offset: CGSize
    public let opacity: CGFloat
    
    /// Returns a `ShadowStyle` instance.
    ///
    /// - Parameters:
    ///   - color: Color for the shadow.
    ///   - radius: Radius for the shadow. This value will decide the spread amount.
    ///   - offset: `CGSize` instance for shadow offset.
    ///   - opacity: Opacity for the shadow.
    public init(color: UIColor, radius: CGFloat, offset: CGSize, opacity: CGFloat) {
        self.color = color
        self.radius = radius
        self.offset = offset
        self.opacity = opacity
    }
}
