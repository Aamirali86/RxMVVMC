//
//  VehicleListCoordinator.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

protocol VehicleListCoordinatorType {
    func showVehicleList()
}

class VehicleListCoordinator: BaseCoordinator<UINavigationController>, VehicleListCoordinatorType {
    func showVehicleList() {
        let viewController = VehicleListBuilder().build()
        rootViewController.pushViewController(viewController, animated: true)
    }
}
