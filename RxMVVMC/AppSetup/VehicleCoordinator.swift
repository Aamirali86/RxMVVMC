//
//  VehicleCoordinator.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

final class VehicleCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        let listVC = VehicleListBuilder().build()
        let mapVC = VehicleMapBuilder().build()

        let tabbarController = UITabBarController(nibName: nil, bundle: nil)
        listVC.tabBarItem = UITabBarItem(title: "List", image: nil, tag: 0)
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: nil, tag: 1)
        tabbarController.viewControllers = [listVC, mapVC]
        rootViewController.pushViewController(tabbarController, animated: true)
    }
}
