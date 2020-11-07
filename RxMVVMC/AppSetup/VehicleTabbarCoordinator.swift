//
//  VehicleTabbarCoordinator.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

final class VehicleTabbarCoordinator: BaseCoordinator<UINavigationController> {
    override func start() {
        let listVC = VehicleListBuilder().build()
        let mapVC = VehicleMapBuilder().build()

        let controller = VehicleTabBarController(firstVC: listVC, secondVC: mapVC)
        rootViewController.pushViewController(controller, animated: true)
    }
}
