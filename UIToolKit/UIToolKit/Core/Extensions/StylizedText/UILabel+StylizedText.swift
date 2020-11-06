//
//  UILabel+StylizedText.swift
//  StyleKit
//

import UIKit

extension UILabel {
    
    private struct AssociatedKeys {
        static var stylizedText = "c_stylizedText"
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
}
