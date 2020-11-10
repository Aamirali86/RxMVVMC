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

final class VehicleMapViewController: BaseViewController {
    //MARK:- Private
    
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
    
    //MARK:- Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}

extension VehicleMapViewController {
    private func setupMapView() {
        mapView.delegate = self
        
        let location = CLLocationCoordinate2D(latitude: 53.5511, longitude: 9.9937)
        let mapRegion = MKCoordinateRegion(center: location, latitudinalMeters: 2500, longitudinalMeters: 2500)
        let adjustedRegion = mapView.regionThatFits(mapRegion)
        mapView.setRegion(adjustedRegion, animated: true)
    }
    
    private func bindViewModel() {
        viewModel
            .vehicles
            .observeOn(MainScheduler.init())
            .subscribe(onNext: { [weak self] (vehicles) in
                self?.removeAllMarkers()
                self?.addMarker(data: vehicles)
        })
        .disposed(by: disposeBag)
    }
    
    private func removeAllMarkers() {
        mapView.removeAnnotations(mapView.annotations)
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

//MARK:- Delegate
extension VehicleMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinates = mapView.getCurrentVisibleEdgeCoordinates()
        viewModel.fetchVehicle(coordinates: coordinates)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = #imageLiteral(resourceName: "car")

        return annotationView
    }
    
}
