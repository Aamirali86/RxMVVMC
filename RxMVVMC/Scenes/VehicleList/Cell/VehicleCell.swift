//
//  VehicleCell.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit
import SwissKnife

class VehicleCell: UITableViewCell {
    @IBOutlet private var state: UILabel!
    @IBOutlet private var type: UILabel!
    @IBOutlet private var heading: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populate(with viewModel: VehicleCellViewModelType) {
        state.text = viewModel.state.rawValue
        type.text = viewModel.type.rawValue
        heading.text = viewModel.heading
    }
}

extension VehicleCell: Instantiatable {}
