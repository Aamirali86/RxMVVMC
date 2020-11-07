//
//  VehicleListBuilder.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

class VehicleListBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "VehicleList", bundle: Bundle.main)
        let viewModel = VehicleListViewModel()
        let controller = storyboard.instantiateInitialViewController {
            VehicleListViewController(coder: $0, viewModel: viewModel)
        }
        
        guard let vehicleViewController = controller else {
            fatalError("Failed to load VehicleListViewController from storyboard.")
        }

        return vehicleViewController
    }
}
