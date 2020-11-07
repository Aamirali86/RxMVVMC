//
//  VehicleResource.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import Foundation
import Network

class VehicleResource: ConsumerEdgeGateway {
    private let token: String
    private let point1: Coordinates
    private let point2: Coordinates
    
    init(token: String, point1: Coordinates, point2: Coordinates) {
        self.token = token
        self.point1 = point1
        self.point2 = point2
    }
    
    let method: HTTPMethod = .get
    var path: String {
        return "PoiService/poi/v1"
    }
    
    var parameters: [String : Parameter]? {
        return [
            "accesstoken": .header(token),
            "Authorization": .header(token),
            "p2Lat": .query(String(point2.latitude)),
            "p1Lon": .query(String(point1.longitude)),
            "p1Lat": .query(String(point1.latitude)),
            "p2Lon": .query(String(point2.longitude)),
        ]
    }
    
    func parse(data: Data, response: HTTPURLResponse) throws -> [Vehicle] {
        let decoder = JSONDecoder()
        let list = try decoder.decode(PoiList.self, from: data)
        return list.poiList
    }
}
