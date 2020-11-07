//
//  AppCoordinator.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

/// `AppCoordinator` is responsible to manage transition at windows level.
final class AppCoordinator: BaseCoordinator<UINavigationController> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(rootViewController: .init())
    }
    
    override func start() {
        let coordinator = VehicleTabbarCoordinator(rootViewController: rootViewController)
        startChild(coordinator)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
