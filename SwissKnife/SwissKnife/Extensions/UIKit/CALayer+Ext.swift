//
//  CALayer+Ext.swift
//  SwissKnife
//

import UIKit

public extension CALayer {
    
    @objc func hideBorder() {
        // Just turn the border transparent, instead of removing it
        borderColor = UIColor.clear.cgColor
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.mask = mask
    }
}
