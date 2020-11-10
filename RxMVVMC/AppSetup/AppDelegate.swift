//
//  AppDelegate.swift
//  RxMVVMC
//
//  Created by Amir on 06/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupGlobalUIAppearence()
        return true
    }
    
    private func setupGlobalUIAppearence() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 20)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 20)!], for: .selected)
    }

}
