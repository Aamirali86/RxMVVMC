//
//  VehicleListViewController.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

class VehicleListViewController: UIViewController {

    var viewModel: VehicleListViewModelType
    
    // MARK:- Init
    init?(coder: NSCoder, viewModel: VehicleListViewModelType) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
