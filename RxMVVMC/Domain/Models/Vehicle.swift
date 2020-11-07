//
//  Vehicle.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import Foundation

struct PoiList: Codable {
    let poiList: [Vehicle]
}

struct Vehicle: Codable {
    let id: Int
    let coordinate: Coordinates
    let state: String
    let type: String
    let heading: Double
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

enum VehicleState: String {
    case active = "ACTIVE"
    case inactive = "INACTIVE"
    case unknown
}

enum VehicleType: String {
    case taxi = "TAXI"
    case unknown
}
