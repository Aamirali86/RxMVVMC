//
//  VehicleListViewModel.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

protocol VehicleListViewModelType {
    var vehicles: Driver<[VehicleTableViewSection]> { get }
    func fetchVehicles()
}

class VehicleListViewModel: VehicleListViewModelType {
    //MARK:- Private
    private let fetchVehicleAction: Action<(Coordinates, Coordinates), [Vehicle]>
    private let _vehicles = ReplaySubject<[Vehicle]>.create(bufferSize: 1)
    private let bag = DisposeBag()
    
    //MARK:- Init
    init(vehicleService: VehicleAPI) {
        fetchVehicleAction = Action { (point1, point2) in
            vehicleService.requestVehicles(with: point1, and: point2)
        }
        
        fetchVehicleAction
            .elements
            .bind(to: _vehicles)
            .disposed(by: bag)
    }
    
    func fetchVehicles() {
        fetchVehicleAction.execute(
            (Coordinates(latitude: 53.694865, longitude: 9.757589)
            , Coordinates(latitude: 53.394655, longitude: 10.099891))
        )
    }
    
    /// fetch vehciles and convert it to used for RxDataSource
    var vehicles: Driver<[VehicleTableViewSection]> {
        _vehicles
            .map {
                let rows = $0.map { vehicle -> VehicleSectionRow in
                    return .vehicleTile(vehicle: vehicle)
                }
                return [VehicleTableViewSection(items: rows)]
            }
            .asDriver(onErrorJustReturn: [])
    }
}
