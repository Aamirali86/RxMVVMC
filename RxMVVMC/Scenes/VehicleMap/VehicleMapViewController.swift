//
//  VehicleMapViewController.swift
//  RxMVVMC
//
//  Created by Amir on 07/11/2020.
//  Copyright © 2020 FreeNow. All rights reserved.
//

import RxSwift
import UIKit
import MapKit
import SwissKnife

class VehicleMapViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var viewModel: VehicleMapViewModelType
    @IBOutlet weak private var mapView: MKMapView! {
        didSet {
            setupMapView()
        }
    }
    
    // MARK:- Init
    init?(coder: NSCoder, viewModel: VehicleMapViewModelType) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewMode()
    }
}

extension VehicleMapViewController {
    private func setupMapView() {
        mapView.delegate = self
        
        let location = CLLocationCoordinate2D(latitude: 53.5511, longitude: 9.9937)
        let mapRegion = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000);
        let adjustedRegion = mapView.regionThatFits(mapRegion)
        mapView.setRegion(adjustedRegion, animated: true)
    }
    
    private func bindViewMode() {
        viewModel.vehicles.subscribe(onNext: { [weak self] (vehicles) in
            guard let self = self else { return }
            
            self.addMarker(data: vehicles)
        })
            .disposed(by: disposeBag)
    }
    
    private func addMarker(data: [Vehicle]) {
        data.forEach { [weak self] (vehicle) in
            self?.addAnnotationPoint(coordinates: vehicle.coordinate)
        }
    }
    
    private func addAnnotationPoint(coordinates: Coordinates) {
        let point = MKPointAnnotation()
        
        point.coordinate = CLLocationCoordinate2DMake(coordinates.latitude, coordinates.longitude)
        mapView.addAnnotation(point)
    }
}

extension VehicleMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinates = mapView.getCurrentVisibleEdgeCoordinates()
        viewModel.fetchVehicle(coordinates: coordinates)
    }
}
