//
//  NetworkService+Vehicles.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import Foundation
import RxSwift
import Network

protocol VehicleAPI {
    func requestVehicles(with point1: Coordinates, and point2: Coordinates) -> Observable<[Vehicle]>
}

extension NetworkService: VehicleAPI {
    func requestVehicles(with point1: Coordinates, and point2: Coordinates) -> Observable<[Vehicle]> {
        let vehicleRequest = VehicleResource(token: "abc123",
                                             point1: point1,
                                             point2: point2)
        return request(vehicleRequest)
    }
}
