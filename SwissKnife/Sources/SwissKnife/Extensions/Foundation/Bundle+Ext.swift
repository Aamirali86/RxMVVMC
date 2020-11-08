//
//  Bundle+Ext.swift
//  SwissKnife
//

import Foundation

public extension Bundle {
    
    @objc var releaseVersionNumber: String {
        guard let version = infoDictionary!["CFBundleShortVersionString"] as? String else {
            fatalError("release version is nil")
        }
        return version
    }
    
    @objc var buildVersionNumber: String {
        guard let bundleVer = infoDictionary![kCFBundleVersionKey as String] as? String else {
            fatalError("bundle version is nil")
        }
        return bundleVer
    }
    
    @objc var bundleName: String {
        guard let bundleName = infoDictionary![kCFBundleNameKey as String] as? String else {
            fatalError("bundle name is nil")
        }
        return bundleName
    }
}

// dummy class to be used to load the framework bundle
private class DummyBundleClass {}

extension Bundle {
    /// returns the bundle for this target, and should always be internal access
    static let local = Bundle(for: DummyBundleClass.self)
}
