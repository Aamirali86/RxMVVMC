//
//  UIView+ViewStyleApplicable.swift
//  StyleKit
//

import UIKit

private var viewStyleKey = "c_viewStyle"

extension UIView {

    /// The view style which is applied to the `UIView` instance. Access is available
    /// over `style` property for consistency reasons.
    fileprivate var viewStyle: ViewStyle? {
        get {
            return objc_getAssociatedObject(self, &viewStyleKey) as? ViewStyle
        }
        set {
            objc_setAssociatedObject(self, &viewStyleKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension Style where Stylable: UIView {

    // Easy access to the `UIView` instance.
    private var view: UIView {
        return stylable as UIView
    }

    /// View style applied to the `UIView` instance. Returns `nil` if there's not any
    /// style applied.
    public var viewStyle: ViewStyle? {
        return view.viewStyle
    }

    // MARK: - Public

    public func apply(_ viewStyle: ViewStyle) {

        view.backgroundColor = viewStyle.backgroundColor
        view.tintColor = viewStyle.tintColor
        view.layer.cornerRadius = viewStyle.cornerRadius
        
        if let borderStyle = viewStyle.borderStyle {
            apply(borderStyle)
        }
        
        if let shadowStyle = viewStyle.shadowStyle {
            apply(shadowStyle)
        }

        // Store the `viewStyle`
        view.viewStyle = viewStyle
    }
    
    // MARK: - Private
    
    private func apply(_ borderStyle: BorderStyle) {

        view.layer.borderColor = borderStyle.color.cgColor
        view.layer.borderWidth = borderStyle.thickness
    }
    
    private func apply(_ shadowStyle: ShadowStyle) {

        view.layer.shadowColor = shadowStyle.color.cgColor
        view.layer.shadowRadius = shadowStyle.radius
        view.layer.shadowOffset = shadowStyle.offset
        view.layer.shadowOpacity = Float(shadowStyle.opacity)
    }
}
