//
//  DateFormatter+Ext.swift
//  SwissKnife
//

import Foundation

public protocol DateFormatterProtocol: class {
    func date(from: String) -> Date?
    func string(from: Date) -> String
}

extension DateFormatter: DateFormatterProtocol {}

public extension DateFormatter {
    
    // MARK: Predefined format functions
    
    /// Returns a `DateFormatterProtocol` instance which uses "d MMM yyyy" format.
    static func d_MMM_yyyy(locale: Locale = Locale.current,
                           timeZone: TimeZone = .current) -> DateFormatterProtocol {
        return formatter(with: "d MMM yyyy",
                         locale: locale,
                         timeZone: timeZone)
    }
    
    /// Returns a `DateFormatterProtocol` instance which uses "MMMM d, yyyy HH:mm" format.
    static func MMMM_d_yyyy_HH_mm(locale: Locale = Locale.current,
                                  timeZone: TimeZone = .current) -> DateFormatterProtocol {
        return formatter(with: "MMMM d, yyyy HH:mm",
                         locale: locale,
                         timeZone: timeZone)
    }
    
    static func HH_mm(locale: Locale = .current,
                      timeZone: TimeZone = .current) -> DateFormatterProtocol {
        return formatter(with: "HH:mm", locale: locale, timeZone: timeZone)
    }
    
    static func hh_mm_a(locale: Locale = .current,
                        timeZone: TimeZone = .current) -> DateFormatterProtocol {
        return formatter(with: "hh:mm a", locale: locale, timeZone: timeZone)
    }
    
    static func EEEE_hh_mm_a(locale: Locale = .current,
                             timeZone: TimeZone = .current) -> DateFormatterProtocol {
        return formatter(with: "EEEE, hh:mm a", locale: locale, timeZone: timeZone)
    }
    
    /// Returns a `DateFormatterProtocol` instance which uses a `DateFormatter.Style.medium` like a format
    /// for dates and `DateFormatter.Style.short` like a format for time which are joined together.
    /// For 9 Oct 2018, 13:53 the output will be:
    ///     - For AR: ٩ أكتوبر، ١:٥٣ م
    ///     - For FR: 9 oct. à 13:53
    ///     - For EN: Oct 9, 1:53 PM
    ///     - For TR: 9 Eki 13:53
    /// If somehow the format can not be formed from template, the fallback format "d MMM, HH:mm"
    /// is used.
    static func d_MMM_j_m(locale: Locale = Locale.current,
                          timeZone: TimeZone = .current) -> DateFormatterProtocol {
        return formatter(with: format(template: "dMMMjm", fallback: "d MMM, HH:mm", locale: locale),
                         locale: locale,
                         timeZone: timeZone)
    }
    
    /// Returns a `DateFormatterProtocol` instance which uses "ISO 8601" format.
    /// ISO-8601 format (yyyy-MM-dd'T'HH:mm:ssZZZZZ) is must for braze attributes
    /// https://www.braze.com/documentation/iOS/#custom-attribute-with-a-date-value
    static func iso8601Format(timeZone: TimeZone = .current) -> DateFormatterProtocol {
        return formatter(with: "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
                         locale: Locale(identifier: "en_US_POSIX"),
                         timeZone: timeZone)
    }
    
    // MARK: Factory function
    
    static func formatter(with format: String,
                          locale: Locale = Locale.current,
                          timeZone: TimeZone = .current,
                          cache: Bool = true) -> DateFormatterProtocol {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        
        return formatter
    }
    
    // MARK: - Private
    
    /** Returns a format based on the given template format.
        e.g. Given the template "jm", based on the locale it will return the appropriate
        hour and date representation such that it may be a 24 hour representation or
        12 hour representation with AM/PM. */
    private static func format(template: String,
                               fallback: String,
                               locale: Locale) -> String {
        let preferredFormat: String
        if let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: locale) {
            preferredFormat = format
        } else {
            preferredFormat = fallback
        }
        return preferredFormat
    }
}
