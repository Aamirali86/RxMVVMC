//
//  ConsumerEdgeGateway.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import Foundation
import Network

/// A type representing a resource on Consumer gateway
protocol ConsumerEdgeGateway: RequestBuilder {}

extension ConsumerEdgeGateway {
    var baseURL: String {
        return "poi-api.mytaxi.com"
    }

    var additionalHeaders: [AdditionalHeaders] {
        return [.device, .authorization]
    }
}
