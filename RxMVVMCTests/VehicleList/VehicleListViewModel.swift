//
//  VehicleListViewModel.swift
//  RxMVVMCTests
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import Foundation
import XCTest
import RxTest
import RxCocoa
import RxSwift
@testable import RxMVVMC

class VehicleListViewModelTest: XCTestCase {
    var viewModel: VehicleListViewModel!
    var vehicleService: MockVehicleAPI!
    var scheduler: TestScheduler!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        vehicleService = MockVehicleAPI(scheduler: scheduler)
        viewModel = VehicleListViewModel(vehicleService: vehicleService)
    }
    
    func testVehicles() {
        vehicleService.vehicleEvent = [
            .next(10, [Vehicle(id: 1238, coordinate: Coordinates(latitude: 24.28, longitude: 54.23), state: "ACTIVE", type: "TAXI", heading: 0.0)]),
            .completed(20)
        ]
        
        SharingScheduler.mock(scheduler: scheduler) {
            let result = scheduler.start { [unowned self] in
                self.viewModel.vehicles.asObservable()
            }
            
            guard let sections = result.events.first?.value.element else { return }
            
            XCTAssertEqual(sections.count, 1)
            
            if case VehicleSectionRow.vehicleTile(let vehicle) = sections[0].items[0] {
                XCTAssertEqual(vehicle.state, "ACTIVE")
                XCTAssertEqual(vehicle.type, "TAXI")
            }
        }
    }
}

class MockVehicleAPI: VehicleAPI {
    let scheduler: TestScheduler
    
    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }
    
    var vehicleEvent: [Recorded<Event<[Vehicle]>>] = []
    func requestVehicles(with point1: Coordinates, and point2: Coordinates) -> Observable<[Vehicle]> {
        return scheduler.createColdObservable(vehicleEvent).asObservable()
    }
}
