//
//  UIViewController+Ext.swift
//  SwissKnife
//

import UIKit

public extension Instantiatable where Self: UIViewController {
    
    /// Creates and returns a view controller from the storyboard.
    /// Rule of thumb is: the view controller class name, the storyboard file name, and the view
    /// controller identifier for the scene in the storyboard all must be identical.
    /// - Returns: A view controller initialized from the storyboard.
    static func instantiate() -> Self {
        return create(type: self,
                      from: UIStoryboard(name: storyboardName, bundle: bundle),
                      with: identifier)
    }
    
    // #warning: Avoid to call this function, as it's here only for legacy support.
    static func instantiate(fromStoryboardWithName name: String,
                            withViewControllerIdentifier viewControllerIdentifier: String? = nil) -> Self {
        return create(type: self,
                      from: UIStoryboard(name: name, bundle: bundle),
                      with: viewControllerIdentifier ?? identifier)
    }
    
    // MARK: - Private
    
    private static var bundle: Bundle {
        return Bundle(for: self)
    }
    
    private static var identifier: String {
        return String(describing: self)
    }
    
    private static var storyboardName: String {
        return String(describing: self)
    }
    
    private static func create<T>(type: T.Type,
                                  from storyboard: UIStoryboard,
                                  with identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
