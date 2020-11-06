//
//  UIImage+Ext.swift
//  SwissKnife
//

import UIKit

public extension UIImage {
    
    // returns the BGRA bytes
    @objc var bytes: [UInt8] {
        return (cgImage?.dataProvider?.data as Data?)
            .flatMap { [UInt8]($0) } ?? []
    }
    
    
    @objc static func fromColor(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    @objc func tint(color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        draw(in: rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setBlendMode(.sourceIn)
        //Multiply - Color Code Black
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
