//
//  UILabel+TextStyleApplicable.swift
//  StyleKit
//

import UIKit

private var textStyleKey = "c_textStyle"

extension UILabel {

    /// The text style which is applied to the `UILabel` instance. Access is available
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

extension Style where Stylable: UILabel {

    // Easy access to the `UILabel` instance.
    private var label: UILabel {
        return stylable as UILabel
    }

    // MARK: - Public

    /// Text style applied to the `UILabel` instance. Returns `nil` if there's not any
    /// style applied.
    public var textStyle: TextStyle? {
        return label.textStyle
    }

    /// Applies the given `textStyle` to the `UILabel` instance and stores it. The
    /// applied style can be accessed with `<UILabel instance>.style.textStyle`.
    ///
    /// - Parameter textStyle: `TextStyle` isntance to be applied.
    public func apply(_ textStyle: TextStyle) {

        // Set an attributed string if we have custom line height attributes. Otherwise use simple customization.
        if textStyle.lineHeightMultiple != nil || textStyle.maximumLineHeight != nil || textStyle.minimumLineHeight != nil {
            guard let text = label.text else { return }
            label.attributedText = StylizedText(text: text, textStyle: textStyle).attributedText
        } else {
            label.font = textStyle.font.uiFont
            label.textColor = textStyle.color
            label.textAlignment = textStyle.alignment
        }

        // Store the `textStyle`
        label.textStyle = textStyle
    }
}
