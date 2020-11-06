//
//  UIView+Instantiate.swift
//  SwissKnife
//

import UIKit

public extension Instantiatable where Self: UIView {
    
    static func instantiate() -> Self {
        return create(type: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }
    
    // MARK: - Private
    
    private static var bundle: Bundle {
        return Bundle(for: self)
    }
    
    private static var nibName: String {
        return String(describing: self)
    }
    
    private static func create<T>(type: T.Type) -> T {
        let nibContents = bundle.loadNibNamed(nibName, owner: nil, options: nil)
        return nibContents?.first { $0 is T } as! T
    }
}

public extension Instantiatable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return nibName
    }
}
public extension Instantiatable where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return nibName
    }
}
public extension Instantiatable where Self: UICollectionReusableView {
    static var reuseIdentifier: String {
        return nibName
    }
}
