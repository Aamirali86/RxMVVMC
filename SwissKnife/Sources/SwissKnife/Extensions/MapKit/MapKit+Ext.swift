//
//  MapKit+Ext.swift
//  SwissKnife
//
//  Created by Amir on 07/11/2020.
//

import Foundation
import MapKit

public typealias EdgesCoordinates = (northEast: CLLocationCoordinate2D, southWest: CLLocationCoordinate2D)

public extension MKMapView {
    func getCurrentVisibleEdgeCoordinates() -> EdgesCoordinates {
        let northEastPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.origin.y)
        let southWestPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        
        let northEastCoord = self.convert(northEastPoint, toCoordinateFrom: self)
        let southWestCoord = self.convert(southWestPoint, toCoordinateFrom: self)
        
        return (northEast: northEastCoord, southWest: southWestCoord)
    }
}
