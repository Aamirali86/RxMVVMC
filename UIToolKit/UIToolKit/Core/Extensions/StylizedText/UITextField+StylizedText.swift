//
//  UITextField+StylizedText.swift
//  StyleKit
//

import UIKit

extension UITextField {
    
    private struct AssociatedKeys {
        static var stylizedText = "c_stylizedText"
        static var stylizedPlaceholderText = "c_stylizedPlaceholderText"
    }
    
    public var stylizedText: StylizedText? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.stylizedText) as? StylizedText
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.stylizedText, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            attributedText = newValue?.attributedText
        }
    }
    
    public var stylizedPlaceholderText: StylizedText? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.stylizedPlaceholderText) as? StylizedText
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.stylizedPlaceholderText, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            attributedPlaceholder = newValue?.attributedText
        }
    }
}
