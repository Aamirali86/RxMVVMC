//
//  NumberFormatter+Ext.swift
//  SwissKnife
//

import Foundation

public protocol NumberFormatterProtocol: class {
    func number(from: String) -> NSNumber?
    func string(from: NSNumber) -> String?
    
    var configuration: NumberFormatter.Configuration { get }
}

extension NumberFormatter: NumberFormatterProtocol {
    
    public var configuration: NumberFormatter.Configuration {
        return NumberFormatter.Configuration(numberStyle: numberStyle,
                                             locale: locale,
                                             positiveFormat: positiveFormat,
                                             negativeFormat: negativeFormat,
                                             minimumIntegerDigits: minimumIntegerDigits,
                                             maximumIntegerDigits: maximumIntegerDigits,
                                             minimumFractionDigits: minimumFractionDigits,
                                             maximumFractionDigits: maximumFractionDigits,
                                             roundingMode: roundingMode,
                                             currencySymbol: currencySymbol)
    }
}

public extension NumberFormatter {
    
    /**
     Configuration type for `NumberFormatter`. This can be expanded with additional properties
     that needs to be passed into the underlying `NumberFormatter` instance.
     */
    struct Configuration {
        let numberStyle: NumberFormatter.Style
        let locale: Locale
        
        /** `NumberFormatter` modifies these values based on the `numberStyle` and `locale`,
         unless they are set explicitly. So having a default value would still result in
         unexpected results given a specific `numberStyle` and `locale` combination. For example,
         even though the default value for `minimumFractionDigits` and `maximumFractionDigits` are
         `0`, if the `numberStyle` is `currency`, they will be set to a different value based
         on the `locale`. And we can assume and set them to `2` for `currency` style because not
         every locale uses 2 digits in fraction part of the value. (Kuwait uses 3. 🤑 ¯\_(ツ)_/¯). */
        let positiveFormat: String?
        let negativeFormat: String?
        let minimumIntegerDigits: Int?
        let maximumIntegerDigits: Int?
        let minimumFractionDigits: Int?
        let maximumFractionDigits: Int?
        let roundingMode: NumberFormatter.RoundingMode?
        let currencySymbol: String?
        
        fileprivate var cacheKey: String {
            var key = "\(numberStyle)_\(numberStyle.rawValue)_" + locale.identifier
            if let value = positiveFormat {
                key += "_\(value)"
            }
            if let value = negativeFormat {
                key += "_\(value)"
            }
            if let value = minimumIntegerDigits {
                key += "_\(value)"
            }
            if let value = maximumIntegerDigits {
                key += "_\(value)"
            }
            if let value = minimumFractionDigits {
                key += "_\(value)"
            }
            if let value = maximumFractionDigits {
                key += "_\(value)"
            }
            if let value = roundingMode {
                key += "_\(value)_\(value.rawValue)"
            }
            if let value = currencySymbol {
                key += "_\(value)"
            }
            return key
        }
        
        public init(numberStyle: NumberFormatter.Style,
                    locale: Locale,
                    positiveFormat: String? = nil,
                    negativeFormat: String? = nil,
                    minimumIntegerDigits: Int? = nil,
                    maximumIntegerDigits: Int? = nil,
                    minimumFractionDigits: Int? = nil,
                    maximumFractionDigits: Int? = nil,
                    roundingMode: NumberFormatter.RoundingMode? = nil,
                    currencySymbol: String? = nil) {
            self.numberStyle = numberStyle
            self.positiveFormat = positiveFormat
            self.negativeFormat = negativeFormat
            self.minimumIntegerDigits = minimumIntegerDigits
            self.maximumIntegerDigits = maximumIntegerDigits
            self.minimumFractionDigits = minimumFractionDigits
            self.maximumFractionDigits = maximumFractionDigits
            self.roundingMode = roundingMode
            self.locale = locale
            self.currencySymbol = currencySymbol
        }
    }
    
    // MARK: Predefined format functions
    
    /// Returns a `NumberFormatter` instance which uses decimal number style format (e.g. 1,234).
    static func decimalFormatter(locale: Locale = Locale.current) -> NumberFormatterProtocol {
        return formatter(with: Configuration(numberStyle: .decimal,
                                             locale: locale))
    }
    
    /// Returns a `NumberFormatter` instance which uses currency style format (e.g. $1,234.57, 1 234,57 €).
    static func currencyFormatter(locale: Locale = Locale.current) -> NumberFormatterProtocol {
        return formatter(with: Configuration(numberStyle: .currency,
                                             locale: locale))
    }
    
    /// Returns a `NumberFormatter` instance which uses currency style format (e.g. USD1,234.57, 1 234,57 EUR, AED1,234.57).
    static func currencyISOCodeFormatter(locale: Locale = Locale.current) -> NumberFormatterProtocol {
        return formatter(with: Configuration(numberStyle: .currencyISOCode,
                                             locale: locale))
    }
    
    // MARK: Factory function
    
    static func formatter(with configuration: Configuration) -> NumberFormatterProtocol {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = configuration.numberStyle
        formatter.locale = configuration.locale
        // NOTE: Setting the positiveFormat after maximumFractionDigits disregards
        // maximumFractionDigits and matches the decimal scale with that of the
        // format. When the positiveFormat is set before the maximumFractionDigits,
        // the NumberFormatter uses maximumFractionDigits for decimal scaling.
        // In the config, iff the maximumFractionDigits is nil, positiveFormat
        // will be used for scaling the decimal.
        if let value = configuration.positiveFormat {
            formatter.positiveFormat = value
        }
        if let value = configuration.negativeFormat {
            formatter.negativeFormat = value
        }
        if let value = configuration.minimumIntegerDigits {
            formatter.minimumIntegerDigits = value
        }
        if let value = configuration.maximumIntegerDigits {
            formatter.maximumIntegerDigits = value
        }
        if let value = configuration.minimumFractionDigits {
            formatter.minimumFractionDigits = value
        }
        if let value = configuration.maximumFractionDigits {
            formatter.maximumFractionDigits = value
        }
        if let value = configuration.roundingMode {
            formatter.roundingMode = value
        }
        if let value = configuration.currencySymbol {
            formatter.currencySymbol = value
        }
        
        return formatter
    }
}
