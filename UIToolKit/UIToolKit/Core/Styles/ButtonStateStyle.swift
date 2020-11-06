//
//  ButtonStateStyle.swift
//  StyleKit
//

import UIKit

public struct ButtonStateStyle {
    
    public var backgroundColor: UIColor
    public var titleTextStyle: TextStyle
    
    public init(backgroundColor: UIColor = .white,
                titleTextStyle: TextStyle = TextStyle()) {
        self.backgroundColor = backgroundColor
        self.titleTextStyle = titleTextStyle
    }
}
