//
//  VehicleTabBarController.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

class VehicleTabBarController: UITabBarController {
    
    init(firstVC: UIViewController, secondVC: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        firstVC.tabBarItem = UITabBarItem(title: "List", image: nil, tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "Map", image: nil, tag: 1)
        viewControllers = [firstVC, secondVC]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
