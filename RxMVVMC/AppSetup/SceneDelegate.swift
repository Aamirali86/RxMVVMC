//
//  SceneDelegate.swift
//  RxMVVMC
//
//  Created by Amir on 06/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let coordinator = AppCoordinator(window: window)
        self.window = window
        self.coordinator = coordinator
        coordinator.start()
    }

}
