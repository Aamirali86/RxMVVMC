//
//  UIButton+ButtonStyleApplicable.swift
//  StyleKit
//

import UIKit

private var buttonStyleKey = "c_buttonStyle"

extension UIButton {

    /// The button style which is applied to the `UIButton` instance. Access is available
    /// over `style` property for consistency reasons.
    fileprivate var buttonStyle: ButtonStyle? {
        get {
            return objc_getAssociatedObject(self, &buttonStyleKey) as? ButtonStyle
        }
        set {
            objc_setAssociatedObject(self, &buttonStyleKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension Style where Stylable: UIButton {

    // Easy access to the `UIButton` instance.
    private var button: UIButton {
        return stylable as UIButton
    }

    /// Button style applied to the `UIButton` instance. Returns `nil` if there's not any
    /// style applied.
    public var buttonStyle: ButtonStyle? {
        return button.buttonStyle
    }

    // MARK: - Public

    public func apply(_ buttonStyle: ButtonStyle) {

        // Apply view style if present
        if let viewStyle = buttonStyle.viewStyle {
            button.style.apply(viewStyle)
        }
        
        let title = button.title(for: .normal) ?? ""
        
        // Normal state styling
        let normalStyle = buttonStyle.normalStateStyle
        apply(normalStyle, title: title, state: .normal)
        
        // Highlighted state styling
        if let highlightedStyle = buttonStyle.highlightedStateStyle {
            let highlightedTitle = button.title(for: .highlighted) ?? title // Fallback to normal title
            apply(highlightedStyle, title: highlightedTitle, state: .highlighted)
            button.adjustsImageWhenHighlighted = false
        }
        
        // Disabled state styling
        if let disabledStyle = buttonStyle.disabledStateStyle {
            let disabledTitle = button.title(for: .disabled) ?? title // Fallback to normal title
            apply(disabledStyle, title: disabledTitle, state: .disabled)
            button.adjustsImageWhenDisabled = false
        }
        
        // Selected state styling
        if let selectedStyle = buttonStyle.selectedStateStyle {
            let selectedTitle = button.title(for: .selected) ?? title // Fallback to normal title
            apply(selectedStyle, title: selectedTitle, state: .selected)
        }

        // Store the `buttonStyle`
        button.buttonStyle = buttonStyle
    }

    // MARK: - Private

    private func apply(_ buttonStateStyle: ButtonStateStyle, title: String, state: UIControl.State) {

        button.setBackgroundImage(imageWithColor(buttonStateStyle.backgroundColor,
                                                 cornerRadius: viewStyle?.cornerRadius ?? 0.0),
                                  for: state)
        button.setAttributedTitle(StylizedText(text: title,
                                               textStyle: buttonStateStyle.titleTextStyle).attributedText,
                                  for: state)
    }
}

/// Creates and returns an image filled with the given color. The size of the image will be 1x1 pixels, if
/// the `cornerRadius` value is `0.0`. Otherwise the image will be extended in size from every side by the
/// amount of `cornerRadius`. The image returned from this function can be resizable. If the `cornerRadius`
/// value is grater than `0.0`, an image containing the cap insets information will be returned.
///
/// - Parameters:
///   - color: Color to fill the image with.
///   - cornerRadius: Radius amount to apply on the rendered image.
/// - Returns: A `UIImage` instance with resizing capabilities.
private func imageWithColor(_ color: UIColor?, cornerRadius: CGFloat = 0.0) -> UIImage? {
    
    guard let color = color else { return nil }
    // Canvas size.
    // 1x1 pixel images resized and rendered with the fastest performance.
    // If we have corner radius, we're leaving a 1x1 pixel area in the middle to be strecth. This is also
    // the most performant option. (see the docs for `resizableImage(withCapInsets:)`)
    let size = CGSize(width: 1.0 + 2.0 * cornerRadius,
                      height: 1.0 + 2.0 * cornerRadius)
    // Draw the image
    let image: UIImage
    if #available(iOS 10.0, *) {
        image = UIGraphicsImageRenderer(size: size).image { context in
            // Set fill color
            color.setFill()
            // Create canvas rectangular
            let rect = CGRect(origin: .zero, size: size)
            // Fill in the canvas. Use rounded bezier path if corner radius is present.
            if cornerRadius > 0 {
                let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
                bezierPath.fill()
            } else {
                context.fill(rect)
            }
        }
    } else {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        // Set fill color
        color.setFill()
        // Create canvas rectangular
        let rect = CGRect(origin: .zero, size: size)
        // Fill in the canvas. Use rounded bezier path if corner radius is present.
        if cornerRadius > 0 {
            let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            bezierPath.fill()
        } else {
            context.fill(rect)
        }
        // Render the image
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    // Create capped image if corner radius is provided.
    if cornerRadius > 0 {
        let capInsets = UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius)
        // Create and return a resizable image.
        return image.resizableImage(withCapInsets: capInsets)
    }
    return image
}
