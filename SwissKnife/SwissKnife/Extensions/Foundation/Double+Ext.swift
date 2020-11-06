//
//  Double+Ext.swift
//  SwissKnife
//

import Foundation


public extension Double {

    // MARK: - private methods
    
    private func roundedString(mode: NumberFormatter.RoundingMode, maxDecimals decimals: Int, numberingStyle style: NumberFormatter.Style) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.maximumFractionDigits = decimals
        formatter.roundingMode = mode
        // NOTE: returns nil if object isn't of correct class, which is impossible
        var result = formatter.string(for: self)!
        
        // (-0.1).roundedString(maxDecimals: 0) returns "-0"
        if result == "-0" {
            result = "0"
        }
        
        return result
    }
    
    
    // MARK: - public methods
    
    func truncate(decimals: Int) -> Double {
        let factor = pow(10, Double(decimals))
        return trunc(self * factor) / factor
    }
    
    // Int(Int32.max) is used because the maximum supported limit for maxDecimals is Int32.max
    func roundedString(maxDecimals decimals: Int = Int(Int32.max), numberingStyle style: NumberFormatter.Style = .decimal) -> String {
        return roundedString(mode: .halfUp, maxDecimals: decimals, numberingStyle: style)
    }
    
    func roundedUpString(maxDecimals decimals: Int) -> String {
        return roundedString(mode: .up, maxDecimals: decimals, numberingStyle: .decimal)
    }
    
    var degreesToRadians: Double { return self * .pi / 180 }
    var radiansToDegrees: Double { return self * 180 / .pi }
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    // This returns true if the double is a perfectly rounded integer
    // For example: True if 1.0
    // False if 1.1
    var isPerfectlyRoundedInteger: Bool {
        return self == floor(self)
    }
}

// OBJC ACCESS

public extension NSNumber {

    @objc func truncateDecimals(_ count: Int) -> Double {
        return doubleValue.truncate(decimals: count)
    }
    
    @objc func roundedString(maxDecimals decimals: Int) -> String {
        return doubleValue.roundedString(maxDecimals: decimals)
    }
    
    @objc func roundedString(maxDecimals decimals: Int, numberingStyle style: NumberFormatter.Style) -> String {
        return doubleValue.roundedString(maxDecimals: decimals, numberingStyle: style)
    }
    
    @objc func roundedUpString(maxDecimals decimals: Int) -> String {
        return doubleValue.roundedUpString(maxDecimals: decimals)
    }
}
