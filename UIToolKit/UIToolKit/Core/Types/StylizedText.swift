//
//  StylizedText.swift
//  StyleKit
//

import UIKit

public struct StylizedText {
    
    private var text: String
    private var attributedTextStorage: NSMutableAttributedString
    
    public var attributedText: NSAttributedString {
        return NSAttributedString(attributedString: attributedTextStorage)
    }
    
    /// Creates and returns a `StylizedText` instance containing the text and the attributes.
    /// Users of this class add more partially attributes to the underlying text.
    ///
    /// - Parameters:
    ///   - text: Text that `StylizedText` instance will maintain.
    ///   - textStyle: `TextStyle` instance that contains the attributes.
    public init(text: String, textStyle: TextStyle = TextStyle()) {
        self.text = text
        attributedTextStorage = NSMutableAttributedString(string: text,
                                                          attributes: attributes(from: textStyle))
    }
    
    /// Adds the given text style to the text inticated by the given `Range<String.Index>` instance.
    ///
    /// - Parameters:
    ///   - textStyle: `TextStyle` instance that contains the attributes.
    ///   - range: Swift type of range indicating a part from the text.
    public func addTextStyle(_ textStyle: TextStyle, for range: Range<String.Index>) {
        attributedTextStorage.addAttributes(attributes(from: textStyle),
                                            range: NSRange(range, in: text))
    }
    
    /// Adds the given text style to the text inticated by the given `NSRange` instance.
    ///
    /// - Parameters:
    ///   - textStyle: `TextStyle` instance that contains the attributes.
    ///   - range: `NSRange` type indicating a part from the text.
    public func addTextStyle(_ textStyle: TextStyle, for range: NSRange) {
        attributedTextStorage.addAttributes(attributes(from: textStyle),
                                            range: range)
    }
    
    /// Appends a `StylizedText` instance to the reciever. Caller is responsible for
    /// adjusting the spacing and/or new lines, etc. The passed in `StylizedText` will
    /// be appended to the end of the receiver.
    ///
    /// - Parameters:
    ///   - stylizedText: `StylizedText` instance to append
    public func append(_ stylizedText: StylizedText) {
        attributedTextStorage.append(stylizedText.attributedText)
    }
}

/// Creates and returns a dictionary containing all the attributes defined by the given `TextStyle`
/// instance. This dictionary can be used directly to create an `NSAttributedString` instance.
///
/// - Parameter textStyle: `TextStyle` instance that contains the attributes.
/// - Returns: A dictionary containing all the attributes.
private func attributes(from textStyle: TextStyle) -> [NSAttributedString.Key: Any] {
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = textStyle.alignment
    
    if let value = textStyle.lineHeightMultiple {
        paragraphStyle.lineHeightMultiple = value
    }
    if let value = textStyle.maximumLineHeight {
        paragraphStyle.maximumLineHeight = value
    }
    if let value = textStyle.minimumLineHeight {
        paragraphStyle.minimumLineHeight = value
    }
    
    return [.font: textStyle.font.uiFont,
            .foregroundColor: textStyle.color,
            .paragraphStyle: paragraphStyle]
}
