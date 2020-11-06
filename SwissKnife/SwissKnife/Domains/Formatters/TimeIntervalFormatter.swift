//
//  TimeIntervalFormatter.swift
//  SwissKnife
//

import UIKit

public class TimeIntervalFormatter {
    
    public init() { }
    
    public func string(from interval: TimeInterval) -> String? {
        guard interval >= 0 else { return nil }
        let minutesValue = minutesFrom(interval)
        let hasMinutes = minutesValue != nil
        let secondsValue = secondsFrom(interval)
        let hasSeconds = secondsValue != nil
        // combine
        if (hasMinutes || hasSeconds) == false { return "0 \(Localized.swissSecPlural())" }
        return [minutesValue, secondsValue].compactMap { $0 }.joined(separator: " ")
    }
    
    private func minutesFrom(_ interval: TimeInterval) -> String? {
        let minutes = Int(interval / 60)
        guard minutes > 0 else { return nil }
        let minutesWord = minutes == 1 ? Localized.swissMin() : Localized.swissMinPlural()
        return String(format: "%d %@", minutes, minutesWord)
    }
    
    private func secondsFrom(_ interval: TimeInterval) -> String? {
        let seconds = Int(interval.truncatingRemainder(dividingBy: 60))
        guard seconds > 0 else { return nil }
        let hasMinutes = interval >= 60
        let secondsValueFormat = hasMinutes ? "%02d %@" : "%d %@"
        let secondsWord = seconds == 1 ? Localized.swissSec() : Localized.swissSecPlural()
        return String(format: secondsValueFormat, seconds, secondsWord)
    }
}
