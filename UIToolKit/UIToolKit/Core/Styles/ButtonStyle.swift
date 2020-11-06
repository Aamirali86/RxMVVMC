//
//  ButtonStyle.swift
//  StyleKit
//

import UIKit

public struct ButtonStyle {
    
    public var normalStateStyle: ButtonStateStyle
    public var highlightedStateStyle: ButtonStateStyle?
    public var disabledStateStyle: ButtonStateStyle?
    public var selectedStateStyle: ButtonStateStyle?
    public var viewStyle: ViewStyle?
    
    /// Initializes a `ButtonStyle` instance.
    ///
    /// - Parameters:
    ///   - normalStateStyle: Button style for `.normal` state.
    ///   - highlightedStateStyle: Button style for `.highlighted` state.
    ///   - disableStateStyle: Button style for `.disabled` state.
    ///   - selectedStateStyle: Button style for `.selected` state.
    ///   - viewStyle: View style for the button. Applies to all control states.
    public init(normalStateStyle: ButtonStateStyle,
                highlightedStateStyle: ButtonStateStyle? = nil,
                disabledStateStyle: ButtonStateStyle? = nil,
                selectedStateStyle: ButtonStateStyle? = nil,
                viewStyle: ViewStyle? = nil) {
        self.normalStateStyle = normalStateStyle
        self.highlightedStateStyle = highlightedStateStyle
        self.disabledStateStyle = disabledStateStyle
        self.selectedStateStyle = selectedStateStyle
        self.viewStyle = viewStyle
    }
}
