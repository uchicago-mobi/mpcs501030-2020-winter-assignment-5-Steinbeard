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
    var place = Place()
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
}




/*
 let settingsURL: URL = ... // location of plist file
 var settings: MySettings?

 if let data = try? Data(contentsOf: settingsURL) {
   let decoder = PropertyListDecoder()
   settings = try? decoder.decode(MySettings.self, from: data)
 }let settingsURL: URL = ... // location of plist file
 var settings: MySettings?

 if let data = try? Data(contentsOf: settingsURL) {
   let decoder = PropertyListDecoder()
   settings = try? decoder.decode(MySettings.self, from: data)
 }
 */
