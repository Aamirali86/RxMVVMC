//
//  String+Ext.swift
//  SwissKnife
//

import UIKit

private extension Int {
    // Todo: checking cases for arabic for more than 100
    func pronounForm(lang: String) -> String {
        switch self {
        case 1:
            return "singular"
        case 2:
            return "dual"
        case 3...10:
            return "plural"
        default:
            return lang == "ar" ? "singular" : "plural"
        }
    }
    
}

public extension String {
    
    // MARK: - Digits
    
    var digits: String {
        let digits = unicodeScalars
            .filter { CharacterSet.decimalDigits.contains($0) }
            .map { Character($0) }
        
        return String(digits)
    }
    
    /// Returns a new string made by removing from both ends of the String characters that are not digits.
    var decimals: String {
        return trimmingCharacters(in: CharacterSet.decimalDigits.inverted)
    }
    
    /// ```
    /// "12.34".doubleValue => 12.34
    /// "1,234.56".doubleValue => 1234.56
    /// "AED 100".doubleValue => nil (because of the extra chars)
    /// ```
    var doubleValue: Double? {
        let formatter = NumberFormatter.decimalFormatter()
        return formatter.number(from: self)?.doubleValue
    }
    
    var correspondingEnglishNumerals: String {
        
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en")
        
        if let number = formatter.number(from: digits) {
            
            if self.contains("+") {
                
                return "+\(number.stringValue)"
            }
            
            return number.stringValue
        }
        
        return self
    }
    
    /// Convert to english locale by only changing digits and keeping other symbols intact at thier place e.g. "٠٧/٢٠١٩" will convert into "07/2019"
    var correspondingEnglishString: String {
        
        guard isEmpty == false else {
            return self
        }
        
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en")
        var result = ""
        for character in self {
            if character.isNumber {
                if let number = formatter.number(from: String(character)) {
                    result += "\(number.stringValue)"
                }
            } else {
                result += String(character)
            }
        }
        return result
    }
    
    var formattedPhoneNumber: String {
        
        guard !isEmpty else {
            return self
        }
        
        var phoneNumber = replacingOccurrences(of: "-", with: "")
        phoneNumber = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        phoneNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
        
        if phoneNumber.first != "+" {
            phoneNumber = "+\(phoneNumber)"
        }
        
        return phoneNumber
    }
    
    // MARK: - Attributed Strings
    
    var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
    // MARK: - Emoji support
    
    //copied from: https://stackoverflow.com/a/39026908
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x3030, 0x00AE, 0x00A9, // Special Characters
            0x1D000...0x1F77F,           // Emoticons
            0x2100...0x27BF,             // Misc symbols and Dingbats
            0xFE00...0xFE0F,             // Variation Selectors
            0x1F900...0x1F9FF:           // Supplemental Symbols and Pictographs
                return true
            default:
                continue
            }
        }
        return false
    }
    
    
    // MARK: - Localization
    
    // ⚠️ use of dynamically mapped localizations!!
    // TODO: Move the associated strings to a separate file and process
    var dynamicallyLocalized: String {
        // swiftlint:disable localized_not_NSLocalized
        return NSLocalizedString(self, comment: "")
        // swiftlint:enable localized_not_NSLocalized
    }
    
    func localizedNumeric(_ num: Int, lang: String, bundle: Bundle = .main) -> String {
        // swiftlint:disable localized_not_NSLocalized
        return NSLocalizedString("\(self)_\(num.pronounForm(lang: lang))", bundle: bundle, comment: "")
        // swiftlint:enable localized_not_NSLocalized
    }
    
    // MARK: - Non empty string
    
    var nonEmpty: String? {
        return isEmpty ? nil : self
    }
    
    /// Trim whitespaces and newlines
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // MARK: - Template URL
    
    var formattedURL: URL? {
        let imageScale = UIScreen.main.scale == 3.0 ? "@3x" : "@2x"
        let formattedURLString = self
            .replacingOccurrences(of: "%1$s", with: "ios", options: .literal, range: nil)
            .replacingOccurrences(of: "%2$s", with: imageScale, options: .literal, range: nil)
        return URL(string: formattedURLString)
    }
}

// OBJC ACCESS

public extension NSString {
    
    // NOTE: using `digits` as a selector causes a latent crash!
    @objc var digitsString: String {
        return (self as String).digits
    }
    
    @objc var attributed: NSMutableAttributedString {
        return (self as String).attributed
    }
        
    @objc var formattedPhoneNumber: String {
        return (self as String).formattedPhoneNumber
    }
}


public extension String {

    /// Returns HTML string ready to be rendered in webview. The functions adds <html> tags
    /// to the string and styling tag based on pramaeters.
    func htmlStyledString(fontFamily: String = "-apple-system", fontColorHex: String? = nil, textAlignment: NSTextAlignment = .natural, fontSize: CGFloat? = nil, lineSpacing: CGFloat? = nil) -> String {
        
        let styledString = withHTMLStyle(fontFamily: fontFamily, fontColorHex: fontColorHex, fontSize: fontSize, lineSpacing: lineSpacing)
        
        let direction = textAlignment == .right ? "rtl" : "ltr"
        let htmlString = "<html dir=\"\(direction)\">" + styledString + "</html>"
        return htmlString
    }
    
    /// Adding styling tag to a given string so it can be rendered as HTML text.
    private func withHTMLStyle(fontFamily: String = "-apple-system", fontColorHex: String? = nil, fontSize: CGFloat? = nil, lineSpacing: CGFloat? = nil) -> String {
        
        let hex = fontColorHex ?? "#000000"
        let htmlFontSize = fontSize != nil ? "\(fontSize!)" : "medium" // Medium is the default font size in HTML
        let prefix = "<style>* { font-size: \(htmlFontSize); font-family: \(fontFamily); color: \(hex); line-height: \(lineSpacing ?? 1.0);}</style>"
        let styledHTML = prefix + self
        
        return styledHTML
    }
    
    /// Assuming the string is HTML string like "<b>Hello</b> World". The function returns
    /// a ready to be displayed attributed text to display in UITextView or UILabel.
    /// - Parameter fontFamily: The font family that will be used across all tags. By default the font is -apple-system which is the system font.
    /// - Parameter fontColorHex: The font color that will be used across all tags unless special style has been provided. By default color is black color
    /// - returns: AttributedString instance
    
    func htmlAttributedString(fontFamily: String = "-apple-system", fontColorHex: String? = nil, textAlignment: NSTextAlignment = .natural, lineSpacing: CGFloat? = nil, fontSize: CGFloat? = nil) -> NSAttributedString? {
        
        let styledHTML = withHTMLStyle(fontFamily: fontFamily, fontColorHex: fontColorHex, fontSize: fontSize)
        
        guard let data = styledHTML.data(using: .utf16) else { return nil }
        do {
            let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
            let attributedText = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            let style = NSMutableParagraphStyle()
            style.alignment = textAlignment
            if let spacing = lineSpacing {
                style.lineSpacing = spacing
            }
            attributedText.addAttributes([.paragraphStyle: style], range: NSRange(location: 0, length: attributedText.length))
            return attributedText
        } catch {
            assertionFailure("Error in creating attributed string from html: \(self)")
            return nil
        }
    }
    
    /// Parse httpBody and result params in key/value pair
    func parseQuery() -> [String: String] {
        var result = [String: String]()
        let pairs = self.components(separatedBy: "&")
        for pair in pairs {
            let parameter = pair.components(separatedBy: "=")
            guard parameter.count == 2,
                let key = parameter.first,
                key.isEmpty == false,
                let value = parameter.last?
                    .replacingOccurrences(of: "+", with: " ")
                    .removingPercentEncoding,
                value.isEmpty == false else { continue }
            result[key] = value
        }
        return result
    }
}

public extension StringProtocol {
    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }
}

public extension String {
    
    // MARK: email
    
    var isValidEmail: Bool {
                
        let emailRegex = "^([^.@]+)(\\.[^.@]+)*@([^.@]+\\.)+([^.@]+)$"
        
        guard let regex = try? NSRegularExpression(pattern: emailRegex, options: .dotMatchesLineSeparators) else { return false }
        let range = NSRange(location: 0, length: self.count)
        return regex.numberOfMatches(in: self, options: [], range: range) != 0
    }
}

public extension String {
    
    // MARK: Replace First Occurence
    func replacingFirstOccurrence(of string: String, with replacement: String) -> String {
        guard let range = self.range(of: string) else { return self }
        return replacingCharacters(in: range, with: replacement)
    }
}

// MARK: - Character Checking
public extension String {
    var isNumeric: Bool {
        return isEmpty == false && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    var isAlphaNumeric: Bool {
        return isEmpty == false && rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil
    }
}
