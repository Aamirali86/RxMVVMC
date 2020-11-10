//
//  VehicleTableViewSection.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import Foundation
import Differentiator

/// To use for RxDataSource
struct VehicleTableViewSection {
    var items: [Item]
}

extension VehicleTableViewSection: SectionModelType {
    typealias Item = VehicleSectionRow
    
    //MARK:- Init
    
    init(original: VehicleTableViewSection, items: [Item]) {
        self = original
        self.items = items
    }
}

enum VehicleSectionRow {
    case vehicleTile(vehicle: Vehicle)
}
