//
//  BaseCoordinaotr.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import UIKit

/// The `BaseCoordinator` is provides basic/abstract implementation of navigations.
/// it is responsible to manage the presentation logic of view controllers.
/// subclass can override `start` implementation for their specific presentation logic.
class BaseCoordinator<T: UIViewController>: Coordinator {
    let rootViewController: T
    var child: Coordinator?
    weak var parent: Coordinator?
    
    init(rootViewController: T) {
        self.rootViewController = rootViewController
    }
    
    /// show first view controller
    func start() {
        assertionFailure("child class must override it.")
    }
}
