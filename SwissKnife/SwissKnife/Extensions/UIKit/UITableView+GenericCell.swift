//
//  UITableView+GenericCell.swift
//  SwissKnife
//

import UIKit

extension UITableView {
    public func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as! T
    }

    public func registerCell<T: UITableViewCell & Instantiatable>(_ type: T.Type) {
        register(type.nib(), forCellReuseIdentifier: type.reuseID)
    }

}

protocol ReusableCell {
    static var reuseID: String { get }
}

extension ReusableCell {
    static var reuseID: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: ReusableCell {}
