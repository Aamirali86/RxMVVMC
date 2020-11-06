//
//  UIDevice+Ext.swift
//  SwissKnife
//

import UIKit


public extension UIDevice {
    
    /**
     returns the device model, such as iPhone6,2
     http://stackoverflow.com/a/27759550/456434
    */
    @objc static var modelName: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { ptr in
                String(validatingUTF8: ptr)
            }
        }
        
        return modelCode ?? "Unknown"
    }
        
    @objc var iPhone: Bool {
        return userInterfaceIdiom == .phone
    }
}
