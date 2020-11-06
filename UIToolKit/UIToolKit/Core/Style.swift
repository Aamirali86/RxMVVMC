//
//  Style.swift
//  StyleKit
//

import UIKit

public final class Style<Stylable> {
    
    public let stylable: Stylable
    
    init(_ stylable: Stylable) {
        self.stylable = stylable
    }
}

// MARK: - StyleApplicable

public protocol StyleApplicable {
    associatedtype AnyStyleApplicable
    var style: AnyStyleApplicable { get }
}

public extension StyleApplicable {
    var style: Style<Self> {
        return Style(self)
    }
}

/// This extension allows every `UIView` instance to have the `style` variable which
/// provides convenience functions for styling each UI element.
extension UIView: StyleApplicable {}
