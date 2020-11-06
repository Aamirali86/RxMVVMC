//
//  UITextField+TextStyleApplicable.swift
//  StyleKit
//

import UIKit

private var textStyleKey = "c_textStyle"

extension UITextField {

    /// The text style which is applied to the `UITextField` instance. Access is available
    /// over `style` property for consistency reasons.
    fileprivate var textStyle: TextStyle? {
        get {
            return objc_getAssociatedObject(self, &textStyleKey) as? TextStyle
        }
        set {
            objc_setAssociatedObject(self, &textStyleKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension Style where Stylable: UITextField {

    // Easy access to the `UITextField` instance.
    private var textField: UITextField {
        return stylable as UITextField
    }

    // MARK: - Public

    /// Text style applied to the `UITextField` instance. Returns `nil` if there's not any
    /// style applied.
    public var textStyle: TextStyle? {
        return textField.textStyle
    }

    public func apply(_ textStyle: TextStyle) {

        // Set an attributed string if we have custom line height attributes. Otherwise use simple customization.
        if textStyle.lineHeightMultiple != nil || textStyle.maximumLineHeight != nil || textStyle.minimumLineHeight != nil {
            guard let text = textField.text else { return }
            textField.attributedText = StylizedText(text: text, textStyle: textStyle).attributedText
        } else {
            textField.font = textStyle.font.uiFont
            textField.textColor = textStyle.color
            textField.textAlignment = textStyle.alignment
        }

        // Store the `textStyle`
        textField.textStyle = textStyle
    }
    
    // TODO: applyPlaceholderTextStyle?
}
