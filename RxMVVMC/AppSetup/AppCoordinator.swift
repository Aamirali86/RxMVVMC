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
    //MARK:- Init
    
    private let window: UIWindow
    
    //MARK:- Init
    
    init(window: UIWindow) {
        self.window = window
        super.init(rootViewController: .init())
    }
    
    //MARK:- Override
    
    override func start() {
        let coordinator = VehicleCoordinator(rootViewController: rootViewController)
        startChild(coordinator)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
