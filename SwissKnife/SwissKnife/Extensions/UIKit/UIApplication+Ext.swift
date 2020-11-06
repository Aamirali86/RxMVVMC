//
//  UIApplication+Ext.swift
//  SwissKnife
//

import UIKit

/** UIApplication extensions. We define this protocol so it can easily be mocked in tests.
 */
@objc public protocol UIApplicationExt {
    
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL) -> Bool
}

public extension UIApplicationExt {
    
    private func processPhoneNumber(_ number: String, scheme: String) -> URL? {
        
        let allowedChars = CharacterSet(charactersIn: ":/?#[]@!$&’()*+,;=").inverted
        let phone = number.addingPercentEncoding(withAllowedCharacters: allowedChars) ?? ""
        
        let telNumber = "\(scheme)://" + phone
        return URL(string: telNumber)
    }
    
    func canOpenPhoneApp(number: String) -> Bool {
        return processPhoneNumber(number, scheme: "tel")
            .flatMap(canOpenURL) ?? false
    }
    
    @discardableResult
    func openPhoneApp(number: String) -> Bool {
        
        if let phoneUrl = processPhoneNumber(number, scheme: "telprompt"), canOpenURL(phoneUrl) {
            return openURL(phoneUrl)
        }
        return false
    }
    
    @discardableResult
    func openSMS(number: String) -> Bool {
        return URL(string: "sms:\(number)").flatMap(openURL) ?? false
    }
    
    @discardableResult
    func openApp(deeplink: String) -> Bool {
        return URL(string: deeplink).flatMap(openURL) ?? false
    }
}

@objc extension UIApplication: UIApplicationExt {
    
    /// opens app page in the settings app
    /// TODO: move this function inside the protol extension once iOS 9.0 is dropped
    public func openSettings(completion: ((Bool) -> Void)? = nil) {
        
        guard let settings = URL(string: UIApplication.openSettingsURLString), canOpenURL(settings) else {
            assertionFailure("Can not open settings..")
            completion?(false)
            return
        }
        
        open(settings, options: [:], completionHandler: completion)
    }
    
    @objc(canOpenPhoneAppWithNumber:)
    public func objc_canOpenPhoneApp(number: String?) -> Bool {
        return number.flatMap(canOpenPhoneApp(number:)) ?? false
    }
    
    @discardableResult
    @objc(openPhoneAppWithNumber:)
    public func objc_openPhoneApp(number: String?) -> Bool {
        return number.flatMap(openPhoneApp(number:)) ?? false
    }
    
    @discardableResult
    @objc(openSMSWithNumber:)
    public func objc_openSMS(number: String?) -> Bool {
        return number.flatMap(openSMS(number:)) ?? false
    }
}
