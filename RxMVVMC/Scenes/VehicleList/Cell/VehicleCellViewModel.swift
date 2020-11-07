//
//  VehicleCellViewModel.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import Foundation

protocol VehicleCellViewModelType {
    var type: VehicleType { get }
    var state: VehicleState { get }
    var heading: String { get }
}

class VehicleCellViewModel: VehicleCellViewModelType {
    var state: VehicleState {
        return VehicleState(rawValue: vehicle.state) ?? .unknown
    }
    
    var heading: String {
        return String(vehicle.heading)
    }
    
    var type: VehicleType {
        return VehicleType(rawValue: vehicle.type) ?? .unknown
    }
    
    private let vehicle: Vehicle
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }
    
    
}
