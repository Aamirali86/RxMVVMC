//
//  StringBoundsExt.swift
//  UIToolKit
//

import UIKit

/** This seems like a Foundation extension, but the `boundingRect` function used here is part of UIKit
 */
public extension NSAttributedString {
    
    func calculateSize(maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil) -> CGSize {
        
        let constraintRect = CGSize(
            width: maxWidth ?? .greatestFiniteMagnitude,
            height: maxHeight ?? .greatestFiniteMagnitude
        )
        
        let boundingBox = boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            context: nil
        )
        
        return CGSize(
            width: ceil(boundingBox.width),
            height: ceil(boundingBox.height)
        )
    }
}

public extension String {
    
    func calculateSize(font: UIFont, maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil) -> CGSize {
        
        let constraintRect = CGSize(
            width: maxWidth ?? .greatestFiniteMagnitude,
            height: maxHeight ?? .greatestFiniteMagnitude
        )
        
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        )
        
        return CGSize(
            width: ceil(boundingBox.width),
            height: ceil(boundingBox.height)
        )
    }
}
