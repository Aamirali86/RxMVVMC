//
//  UITextView+TextStyleApplicable.swift
//  StyleKit
//

import UIKit

private var textStyleKey = "c_textStyle"

extension UITextView {

    /// The text style which is applied to the `UITextView` instance. Access is available
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

extension Style where Stylable: UITextView {

    // Easy access to the `UITextView` instance.
    private var textView: UITextView {
        return stylable as UITextView
    }

    // MARK: - Public

    /// Text style applied to the `UITextView` instance. Returns `nil` if there's not any
    /// style applied.
    public var textStyle: TextStyle? {
        return textView.textStyle
    }

    public func apply(_ textStyle: TextStyle) {

        // Set an attributed string if we have custom line height attributes. Otherwise use simple customization.
        if textStyle.lineHeightMultiple != nil || textStyle.maximumLineHeight != nil || textStyle.minimumLineHeight != nil {
            guard let text = textView.text else { return }
            textView.attributedText = StylizedText(text: text, textStyle: textStyle).attributedText
        } else {
            textView.font = textStyle.font.uiFont
            textView.textColor = textStyle.color
            textView.textAlignment = textStyle.alignment
        }

        // Store the `textStyle`
        textView.textStyle = textStyle
    }
}
