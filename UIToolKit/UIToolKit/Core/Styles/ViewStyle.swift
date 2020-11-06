//
//  ViewStyle.swift
//  StyleKit
//

import UIKit

public struct ViewStyle {
    
    public var backgroundColor: UIColor?
    public var tintColor: UIColor?
    public var cornerRadius: CGFloat
    public var borderStyle: BorderStyle?
    public var shadowStyle: ShadowStyle?
    
    /// Returns a `ViewStyle` instance. All the properties are optional and can be modified after
    /// initialization.
    ///
    /// - Parameters:
    ///   - backgroundColor: Background color for the view. A `nil` value removes the color information
    ///   from the view, allowing the view to use the default value (depending on the type).
    ///   - tintColor: Tint color for the view. A `nil` value removes the tint color information from the
    ///   view. In this case `UIKit` handles tint color.
    ///   - cornerRadius: If non-zero, applies a corner radius on the view. This will also mask all subview.
    ///   - borderStyle: Border style instance for to be applied.
    ///   - shadowStyle: Shadow style instance for to be applied.
    public init(backgroundColor: UIColor? = nil,
                tintColor: UIColor? = nil,
                cornerRadius: CGFloat = 0.0,
                borderStyle: BorderStyle? = nil,
                shadowStyle: ShadowStyle? = nil) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.cornerRadius = cornerRadius
        self.borderStyle = borderStyle
        self.shadowStyle = shadowStyle
    }
}
