//
//  PlaceMarkerView.swift
//  WhereIntheWorld
//
//  Created by Daniel Steinberg on 2/11/20.
//  Copyright © 2020 Daniel Steinberg. All rights reserved.
//

import UIKit
import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {
    var place: Place?
    override var annotation: MKAnnotation? {
        willSet {
              clusteringIdentifier = "Place"
              displayPriority = .defaultLow
              markerTintColor = .systemRed
              glyphImage = UIImage(systemName: "pin.fill")
        }
    }
}

class Place: MKPointAnnotation {
    var name: String?
    var longDescription: String?
    init(_ data: PlaceData) {
        super.init()
        self.name = data.name
        self.longDescription = data.description
        self.coordinate = CLLocationCoordinate2D(latitude: data.lat, longitude: data.long)
    }
}
