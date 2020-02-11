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
    @IBOutlet var starButton: UIButton!
    @IBOutlet var favoritesButton: UIButton!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.790426, longitude: -87.599199), span: span)
        mapView.region = region
        //starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.isSelected = false
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints())
    }
    
    func constraints() -> [NSLayoutConstraint] {
        return [
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoritesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            favoritesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesButton.heightAnchor.constraint(equalToConstant: 80)
        ]
    }

}

