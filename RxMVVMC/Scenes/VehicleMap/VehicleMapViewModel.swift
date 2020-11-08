//
//  VehicleMapViewModel.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action
import SwissKnife

protocol VehicleMapViewModelType {
    var vehicles: Observable<[Vehicle]> { get }
    func fetchVehicle(coordinates: EdgesCoordinates)
}

class VehicleMapViewModel: VehicleMapViewModelType {
    private let fetchVehicleAction: Action<(Coordinates, Coordinates), [Vehicle]>
    private let _vehicles = ReplaySubject<[Vehicle]>.create(bufferSize: 1)
    private let bag = DisposeBag()
    
    init(vehicleService: VehicleAPI) {
        fetchVehicleAction = Action { (point1, point2) in
            vehicleService.requestVehicles(with: point1, and: point2)
        }
        
        fetchVehicleAction
            .elements
            .bind(to: _vehicles)
            .disposed(by: bag)
    }
    
    func fetchVehicle(coordinates: EdgesCoordinates) {
        fetchVehicleAction.execute(
            (Coordinates(latitude: coordinates.southWest.latitude, longitude: coordinates.southWest.longitude),
             Coordinates(latitude: coordinates.northEast.latitude, longitude: coordinates.northEast.longitude))
        )
    }
    
    var vehicles: Observable<[Vehicle]> {
        _vehicles.asObservable()
    }
}
