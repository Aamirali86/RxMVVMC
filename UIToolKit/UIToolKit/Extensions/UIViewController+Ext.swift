//
//  UIViewController+Ext.swift
//  UIToolKit
//

import UIKit

/// Simplifying addition and removal of child view controllers
/// https://www.swiftbysundell.com/basics/child-view-controllers
public extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
