//
//  UIView+Autolayout.swift
//  SwissKnife
//

import UIKit

public extension UIView {
    
    @objc func embedView(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
            ])
    }
    
    @objc func embedViewCentered(_ subview: UIView, offset: UIOffset = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: centerXAnchor, constant: offset.horizontal),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor, constant: offset.vertical)
            ])
    }
    
    @objc func embedViewToBottom(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        
        let modifiedBottomAnchor: NSLayoutYAxisAnchor
        
        // This IF condition exists because of the
        // Property safeAreaLayoutGuide in UIView (only available in iOS 11 and later)
        if #available(iOS 11.0, *) {
            modifiedBottomAnchor = safeAreaLayoutGuide.bottomAnchor
        } else {
            modifiedBottomAnchor = bottomAnchor
        }
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.bottomAnchor.constraint(equalTo: modifiedBottomAnchor, constant: -insets.bottom),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
            ])
    }
    
    @objc func embedViewToTop(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        
        let modifiedTopAnchor: NSLayoutYAxisAnchor
        
        // This IF condition exists because of the
        // Property safeAreaLayoutGuide in UIView (only available in iOS 11 and later)
        if #available(iOS 11.0, *) {
            modifiedTopAnchor = safeAreaLayoutGuide.topAnchor
        } else {
            modifiedTopAnchor = topAnchor
        }
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.topAnchor.constraint(equalTo: modifiedTopAnchor, constant: -insets.top),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
            ])
    
    }
}
