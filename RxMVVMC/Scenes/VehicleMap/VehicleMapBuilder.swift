//
//  VehicleMapBuilder.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit
import Network

class VehicleMapBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "VehicleMap", bundle: Bundle.main)
        
        let vehicleAPI = NetworkService(network: URLSession.shared,
                                        vendorId: "",
                                        appVersion: "")
        
        let viewModel = VehicleMapViewModel(vehicleService: vehicleAPI)
        let controller = storyboard.instantiateInitialViewController {
            VehicleMapViewController(coder: $0, viewModel: viewModel)
        }
        
        guard let vehicleMapViewController = controller else {
            fatalError("Failed to load VehicleMapViewController from storyboard.")
        }
        
        return vehicleMapViewController
    }
}
