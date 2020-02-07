//
//  ViewController.swift
//  WhereIntheWorld
//
//  Created by Daniel Steinberg on 2/7/20.
//  Copyright © 2020 Daniel Steinberg. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.790426, longitude: -87.599199), span: span)
        mapView.region = region
        
    }


}

