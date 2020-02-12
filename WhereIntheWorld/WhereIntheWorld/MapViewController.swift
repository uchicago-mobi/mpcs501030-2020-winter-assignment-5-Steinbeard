//
//  ViewController.swift
//  WhereIntheWorld
//
//  Created by Daniel Steinberg on 2/7/20.
//  Copyright © 2020 Daniel Steinberg. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, PlacesFavoritesDelegate {
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var starButton: UIButton!
    @IBOutlet var favoritesButton: UIButton!
    @IBOutlet var detailBox: UIView!
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var detailDescription: UILabel!
    let locationManager = CLLocationManager()
    let id = MKMapViewDefaultAnnotationViewReuseIdentifier
    let places = DataManager.sharedInstance.loadAnnotationFromPlist()
    var selectedAnnotation: Place?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set view properties
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.870522, longitude: -87.65), span: span)
        mapView.region = region
        mapView.delegate = self
        mapView.register(PlaceMarkerView.self, forAnnotationViewWithReuseIdentifier: id)
        detailBox.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        starButton.isSelected = false
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        //Layout contraints
        mapView.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints())
        // Add annotations
        for placeData in places {
            let annotation = Place(placeData)
            mapView.addAnnotation(annotation)
        }
    }
    
    // Wire favorites menu as delegator
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let favoritesVC = segue.destination as? FavoritesViewController {
            favoritesVC.delegate = self
        }
    }
    
    @IBAction func toggleFavorite(_ sender: Any) {
        let dataManager = DataManager.sharedInstance
        if let name = selectedAnnotation?.name {
            let currentFavorites = dataManager.listFavorites()
            if currentFavorites.contains(name) {
                dataManager.deleteFavorite(placeName: name)
                starButton.isSelected = false
            } else {
                dataManager.addFavorite(placeName: name)
                starButton.isSelected = true
            }
        }
    }
    
    func goToFavoritePlace(name: String) {
        let places = mapView.annotations.filter({$0 is Place}) as? [Place]
        if let place = places?.first(where: {$0.name == name}) {
            let newSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let newRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude), span: newSpan)
            mapView.region = newRegion
            mapView.selectAnnotation(place, animated: true)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Place else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        if annotationView == nil {
            annotationView = PlaceMarkerView(annotation: annotation, reuseIdentifier: id)
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? Place
        detailTitle.text = selectedAnnotation?.name
        detailDescription.text = selectedAnnotation?.longDescription
        starButton.isSelected = false
        if let name = selectedAnnotation?.name {
            let favorites = DataManager.sharedInstance.listFavorites()
            if favorites.contains(name) {
                starButton.isSelected = true
            }
        }
    }
}
