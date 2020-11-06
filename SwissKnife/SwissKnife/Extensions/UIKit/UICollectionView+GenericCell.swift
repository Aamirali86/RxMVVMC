//
//  UICollectionView+GenericCell.swift
//  SwissKnife
//

import UIKit

public extension UICollectionView {
    func registerCell<T: UICollectionViewCell & Instantiatable>(_ type: T.Type) {
        register(type.nib(), forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueCell<T: UICollectionViewCell & Instantiatable>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
