//
//  UIScreen+Ext.swift
//  SwissKnife
//

import UIKit

@objc public enum ScreenSizeClass: Int {
    
    /// Other iPhones 🤷‍♀️
    case other
    /// iPhone 5, 5s, 5c, SE
    case inch40
    /// iPhone 6, 5s, 7, 8
    case inch47
    /// iPhone 6+, 6s+, 7+, 8+
    case inch55
    /// iPhone X, Xs
    case inch58
    /// iPhone XR, Xs Max (They share same size in points)
    case inch61_65
}

public extension UIScreen {
    
    @objc var sizeClass: ScreenSizeClass {
        
        let height = max(bounds.height, bounds.width)
        switch height {
        case 568: return .inch40
        case 667: return .inch47
        case 736: return .inch55
        case 812: return .inch58
        case 896: return .inch61_65
        default: return .other
        }
    }
    
    @objc var hasNotch: Bool {
        switch sizeClass {
        case .inch58, .inch61_65:
            return true
        case .other, .inch40, .inch47, .inch55:
            return false
        }
    }
    
    @objc var homeIndicator: CGFloat {
        if hasNotch {
            return 34
        } else {
            return 0
        }
    }
}
