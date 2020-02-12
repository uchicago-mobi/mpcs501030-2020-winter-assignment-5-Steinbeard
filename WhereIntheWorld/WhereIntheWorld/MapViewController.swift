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
    @IBOutlet var detailBox: UIView!
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var detailDescription: UILabel!
    let locationManager = CLLocationManager()
    let id = MKMapViewDefaultAnnotationViewReuseIdentifier
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.790426, longitude: -87.599199), span: span)
        mapView.region = region
        mapView.delegate = self
        detailBox.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        
        starButton.isSelected = false
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints())
        
        mapView.register(PlaceMarkerView.self, forAnnotationViewWithReuseIdentifier: id)
        
        DataManager.sharedInstance.saveFavorites(favorites: ["Wrigley Field", "Monkey Jungle", "Big Boy Creek"])
        print(DataManager.sharedInstance.loadAnnotationFromPlist())
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

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        guard let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: id, for: annotation) as? MKMarkerAnnotationView else {
            return nil
        }
        annotationView.animatesWhenAdded = true
        annotationView.canShowCallout = true
        return annotationView
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        guard view.isKind(of: PlaceMarkerView.self) else {
//            return
//        }
//        detailTitle.text = view.annotation.name
//        
//    }
}
