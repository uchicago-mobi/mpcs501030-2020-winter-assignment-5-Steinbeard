//
//  DataManager.swift
//  WhereIntheWorld
//
//  Created by Daniel Steinberg on 2/11/20.
//  Copyright © 2020 Daniel Steinberg. All rights reserved.
//

import Foundation

public class DataManager {
    public static let sharedInstance = DataManager()
    let defaults = UserDefaults.standard
    
    fileprivate init() {
        if defaults.object(forKey: "favorites") == nil {
            //No existing favorites
            print("First time using this dang app!")
            defaults.set([String](), forKey: "favorites")
        }
    }
    // retrieve annotations and store favorites in user defaults
    func loadAnnotationFromPlist() -> [PlaceData]? {
        var places: DataPlaces? = DataPlaces()
        if let url = Bundle.main.url(forResource: "Data", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
                var root = try decoder.decode(RootDictionary.self, from: data)
                places = root.places
            } catch {
                print(error)
            }
        }
        return places
//        var places: [PlaceData]?
//        if let data = try? Data(contentsOf: dataURL) {
//            let decoder = PropertyListDecoder()
//            for place
//            places = try? decoder.decode(PlaceData.self, from: data)
//        }
    }
    
    func saveFavorites(favorites: [String]) {
        defaults.set(favorites, forKey: "favorites")
    }
    
    func deleteFavorite() {}
    func listFavorites() {}
}

private struct RootDictionary: Codable {
    var places: DataPlaces
    var region: [Double]
}

private typealias DataPlaces = [PlaceData]

struct PlaceData: Codable {
    var name: String
    var description: String
    var lat: Double
    var long: Double
}

//NSCodable Place object for storing in User Defaults
//class NSPlace : NSObject, NSCoding {
//    var name: String
//    var description: String
//    var lat: Float
//    var long: Float
//
//    required init?(coder: NSCoder) {
//        <#code#>
//    }
//
//    func encode(with coder: NSCoder) {
//        <#code#>
//    }
//}
