//
//  VehicleCell.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit
import SwissKnife

final class VehicleCell: UITableViewCell {
    //MARK:- Private
    
    @IBOutlet private var state: UILabel!
    @IBOutlet private var type: UILabel!
    @IBOutlet private var heading: UILabel!

    func populate(with viewModel: VehicleCellViewModelType) {
        state.text = viewModel.state.rawValue
        type.text = viewModel.type.rawValue
        heading.text = viewModel.heading
    }
}

extension VehicleCell: Instantiatable {}
