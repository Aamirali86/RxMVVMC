//
//  UIView+Ext.swift
//  SwissKnife
//

import UIKit

private let kCornerRadius: CGFloat = 14.0

extension UIView {
    
    @objc open var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @objc public func applyShadowAndCornerRadius(_ radius: CGFloat, showsShadow: Bool) {
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowRadius = 8.0
        if showsShadow == true {
            layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor // 0,0,0
        }
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowOpacity = 0.15
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
    }
}

extension UIView {
    
    /// - parameter type: The type of subview that you search for
    /// - returns: The first subview that matches the given class type (DFS search)
    @objc public func firstSubViewMatching(type: AnyClass) -> UIView? {
        return search(type)
    }
    
    private func search(_ type: AnyClass) -> UIView? {
        for subView in subviews {
            if subView.isKind(of: type) {
                return subView
            } else {
                if let view = subView.search(type) {
                    return view
                }
            }
        }
        return nil
    }
}

extension UIView {
    
    @objc public func roundTop() {
        round(around: [.topLeft, .topRight])
    }
    
    @objc public func roundBottom() {
        round(around: [.bottomLeft, .bottomRight])
    }
    
    @objc public func roundLeft() {
        round(around: [.topLeft, .bottomLeft])
    }
    
    @objc public func roundRight() {
        round(around: [.topRight, .bottomRight])
    }
    
    @objc public func round(around corners: UIRectCorner) {
        layer.masksToBounds = true
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 20.0, height: 20.0)).cgPath
        layer.mask = mask
    }
}

extension UIView {
    
    @objc public func drawToolTip(size: CGFloat, x: CGFloat, y: CGFloat, up: Bool, fillColor: UIColor) {
        
        let triangleLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        trianglePath.move(to: .zero)
        trianglePath.addLine(to: CGPoint(x: -size, y: up ? size : -size))
        trianglePath.addLine(to: CGPoint(x: size, y: up ? size : -size))
        trianglePath.close()
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = fillColor.cgColor
        triangleLayer.anchorPoint = .zero
        triangleLayer.position = CGPoint(x: x, y: y)
        triangleLayer.name = "triangle"
        triangleLayer.zPosition = 1
        self.layer.addSublayer(triangleLayer)
        self.layer.zPosition = 1
    }
}

extension UIView {
    
    @objc public func addShimmeringAnimation(bgColor: UIColor, gradientFrame: CGRect, gradientRadius: CGFloat = 0.0, cornerRadius: CGFloat = 2.0) {
        
        backgroundColor = bgColor
        let solid = UIColor.white.cgColor
        let clear = UIColor(white: 1, alpha: 0.5).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientFrame
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.colors = [solid, clear, solid]
        gradientLayer.cornerRadius = gradientRadius
        layer.mask = gradientLayer
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.5
        animation.fillMode = .forwards
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animation]
        animationGroup.duration = 2.0
        animationGroup.repeatCount = .infinity
        gradientLayer.add(animationGroup, forKey: "shimmer")

    }
    
    @objc public func removeShimmeringAnimation() {
        backgroundColor = UIColor.clear
        layer.mask = nil
        layer.cornerRadius = 0
        layer.masksToBounds = false
    }
}
