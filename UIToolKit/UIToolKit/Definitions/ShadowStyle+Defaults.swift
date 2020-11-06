//
//  ShadowStyle+Defaults.swift
//  UIToolKit
//

import UIKit

///
/// Default definitions of shadow styles
///
public extension ShadowStyle {
    
    /// We use light elivation on light backgrounds like white papers.
    enum Light {
        
        /// Light shadow with 10% Color.shade01 (#606C74), 10.0 radius, and offset (width: 0.0, height: 1.0)
        public static let shortElevation = ShadowStyle(color: Color.shade01.withAlphaComponent(0.10),
                                                       radius: 10.0,
                                                       offset: CGSize(width: 0.0, height: 1.0),
                                                       opacity: 1.0)
        
        /// Light shadow with 13% Color.shade01 (#606C74), 20.0 radius, and offset (width: 0.0, height: 3.0)
        public static let mediumElevation = ShadowStyle(color: Color.shade01.withAlphaComponent(0.13),
                                                        radius: 20.0,
                                                        offset: CGSize(width: 0.0, height: 3.0),
                                                        opacity: 1.0)
        
        /// Light shadow with 16% Color.shade01 (#606C74), 30.0 radius, and offset (width: 0.0, height: 6.0)
        public static let longElevation = ShadowStyle(color: Color.shade01.withAlphaComponent(0.16),
                                                      radius: 30.0,
                                                      offset: CGSize(width: 0.0, height: 6.0),
                                                      opacity: 1.0)
    }
    
    /// We use dark elivation on dark backgrounds like map.
    enum Dark {
        
        /// Dark shadow with 20% Color.black (#2D2E2E), 10.0 radius, and offset (width: 0.0, height: 1.0)
        public static let shortElevation = ShadowStyle(color: Color.black.withAlphaComponent(0.20),
                                                       radius: 10.0,
                                                       offset: CGSize(width: 0.0, height: 1.0),
                                                       opacity: 1.0)
        
        /// Dark shadow with 25% Color.black (#2D2E2E), 20.0 radius, and offset (width: 0.0, height: 3.0)
        public static let mediumElevation = ShadowStyle(color: Color.black.withAlphaComponent(0.25),
                                                        radius: 20.0,
                                                        offset: CGSize(width: 0.0, height: 3.0),
                                                        opacity: 1.0)
        
        /// Dark shadow with 30% Color.black (#2D2E2E), 30.0 radius, and offset (width: 0.0, height: 6.0)
        public static let longElevation = ShadowStyle(color: Color.black.withAlphaComponent(0.30),
                                                      radius: 30.0,
                                                      offset: CGSize(width: 0.0, height: 6.0),
                                                      opacity: 1.0)
    }
}
