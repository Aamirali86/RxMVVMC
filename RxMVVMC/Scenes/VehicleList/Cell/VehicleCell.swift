//
//  VehicleCell.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIToolKit
import SwissKnife

class VehicleCell: UITableViewCell {
    @IBOutlet private var state: UILabel!
    @IBOutlet private var type: UILabel!
    @IBOutlet private var heading: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populate(with viewModel: VehicleCellViewModelType) {
        state.stylizedText = StylizedText(text: viewModel.state.rawValue, textStyle: TextStyle.medium)
        type.stylizedText = StylizedText(text: viewModel.type.rawValue, textStyle: TextStyle.medium)
        heading.stylizedText = StylizedText(text: viewModel.heading, textStyle: TextStyle.small)
    }
}

extension VehicleCell: Instantiatable {}
