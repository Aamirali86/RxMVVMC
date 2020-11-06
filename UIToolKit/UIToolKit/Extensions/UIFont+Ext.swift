//
//  UIFont+Ext.swift
//  SwissKnife
//

import UIKit

public extension UIFont {

    @objc class func regular(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize)
    }
    
    @objc class func medium(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
    }
    
    @objc class func semibold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.semibold)
    }
    
    @objc class func light(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.light)
    }
    
    @objc class func bold(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    @objc class func italic(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: fontSize)
    }
    
}
