//
//  CurrencyFormatter.swift
//  SwissKnife
//

import Foundation

public class CurrencyFormatter {
    
    // MARK: - Types
    
    public enum Separator: String {
        case hyphen = "-"
        case spaceEnclosedHyphen = " - "
    }
    
    // MARK: - Interface
    
    public static func string(price: Double, minimumFractionDigits: Int = 0, maximumFractionDigits: Int = 0, roundingMode: NumberFormatter.RoundingMode = .halfUp, currencyCode: String, language: String, includeCurrencyCode: Bool = true) -> String {
        let formatter = NumberFormatter.formatter(with:
            configuration(minimumFractionDigits: minimumFractionDigits,
                          maximumFractionDigits: maximumFractionDigits,
                          roundingMode: roundingMode,
                          currencyCode: currencyCode.dynamicallyLocalized,
                          language: language,
                          includeCurrencyCode: includeCurrencyCode)
        )
        
        return sanitizedString(formatter.string(from: NSNumber(value: price))!, using: formatter)
    }
    
    public static func string(minPrice: Double, maxPrice: Double, minimumFractionDigits: Int = 0, maximumFractionDigits: Int = 0, currencyCode: String, language: String, separator: Separator = .spaceEnclosedHyphen, includeCurrencyCode: Bool = true) -> String {
        let min = minPriceString(minPrice, decimalScale: maximumFractionDigits, currencyCode: currencyCode, language: language, includeCurrencyCode: includeCurrencyCode)
        let max = maxPriceString(maxPrice, decimalScale: maximumFractionDigits, currencyCode: currencyCode, language: language, includeCurrencyCode: includeCurrencyCode)
        return "\(min)\(separator.rawValue)\(max)"
    }
}

private extension CurrencyFormatter {
    
    // MARK: - NumberFormatter configurations
    static func configuration(minimumFractionDigits: Int, maximumFractionDigits: Int, roundingMode: NumberFormatter.RoundingMode, currencyCode: String, language: String, includeCurrencyCode: Bool) -> NumberFormatter.Configuration {
        let languageDirection = Locale.characterDirection(forLanguage: language)
        return NumberFormatter.Configuration(numberStyle: includeCurrencyCode ? .currency : .decimal,
                                             locale: Locale(identifier: language),
                                             positiveFormat: positiveFormat(languageDirection: languageDirection, includeCurrencyCode: includeCurrencyCode),
                                             negativeFormat: negativeFormat(languageDirection: languageDirection, includeCurrencyCode: includeCurrencyCode),
                                             minimumFractionDigits: minimumFractionDigits,
                                             maximumFractionDigits: maximumFractionDigits,
                                             roundingMode: roundingMode,
                                             // NumberFormatter.currencySymbol works better than currencyCode with non latin alphabets
                                             currencySymbol: includeCurrencyCode ? currencyCode : nil
                                             )
    }
    
    // MARK: - Formatted string sanitization
    static func sanitizedString(_ string: String, using formatter: NumberFormatterProtocol) -> String {
        // Sanitizing for negative zero: (-0.1) returns "-0" instead of "0"
        return formatter.number(from: string) == 0 ? formatter.string(from: 0)! : string
    }
    
    // MARK: - Formatting Helpers
    static func positiveFormat(languageDirection: Locale.LanguageDirection, includeCurrencyCode: Bool) -> String? {
        switch (languageDirection, includeCurrencyCode) {
        case (.leftToRight, true):
            // force {currency}{space}{price} because some locales don't add a space
            return "¤ #,###.#"
        default:
            // default to the locale format
            return nil
        }
    }
    
    static func negativeFormat(languageDirection: Locale.LanguageDirection, includeCurrencyCode: Bool) -> String? {
        switch (languageDirection, includeCurrencyCode) {
        case (.leftToRight, true):
            // force {currency}{space}{-price} because some locales don't add a space
            return "¤ -"
        default:
            // default to the locale format
            return nil
        }
    }
    
    // MARK: - Range Formatting Helpers
    static func minPriceString(_ value: Double, decimalScale: Int, currencyCode: String, language: String, includeCurrencyCode: Bool) -> String {
        let languageDirection = Locale.characterDirection(forLanguage: language)
        switch languageDirection {
        case .rightToLeft:
            // format {currency}{space}{max-price}{separator}{min-price} so min price should not include currency
            return string(price: value, maximumFractionDigits: decimalScale, currencyCode: currencyCode, language: language, includeCurrencyCode: false)
        default:
            // default every other direction to .leftToRight
            // format {currency}{space}{min-price}{separator}{max-price} so min price should include currency (if required)
            return string(price: value, maximumFractionDigits: decimalScale, currencyCode: currencyCode, language: language, includeCurrencyCode: includeCurrencyCode)
        }
    }
    
    static func maxPriceString(_ value: Double, decimalScale: Int, currencyCode: String, language: String, includeCurrencyCode: Bool) -> String {
        let languageDirection = Locale.characterDirection(forLanguage: language)
        switch languageDirection {
        case .rightToLeft:
            // format {currency}{space}{max-price}{separator}{min-price} so max price should include currency (if required)
            return string(price: value, maximumFractionDigits: decimalScale, currencyCode: currencyCode, language: language, includeCurrencyCode: includeCurrencyCode)
        default:
            // format {currency}{space}{min-price}{separator}{max-price} so max price should not include currency
            return string(price: value, maximumFractionDigits: decimalScale, currencyCode: currencyCode, language: language, includeCurrencyCode: false)
        }
    }
}
