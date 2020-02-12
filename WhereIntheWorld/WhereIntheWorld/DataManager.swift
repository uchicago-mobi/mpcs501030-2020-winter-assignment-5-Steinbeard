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
            defaults.set([String](), forKey: "favorites")
        }
    }

    func loadAnnotationFromPlist() -> [PlaceData] {
        var places = [PlaceData]()
        if let url = Bundle.main.url(forResource: "Data", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
                let root = try decoder.decode(RootDictionary.self, from: data)
                places = root.places
            } catch {
                print(error)
            }
        }
        return places
    }
    
    func saveFavorites(names: [String]) {
        defaults.set(names, forKey: "favorites")
    }
    
    func addFavorite(placeName: String) {
        var favorites = listFavorites()
        favorites.append(placeName)
        saveFavorites(names: favorites)
    }
    
    func deleteFavorite(placeName: String) {
        let oldFavorites = listFavorites()
        let newFavorites = oldFavorites.filter(){$0 != placeName}
        saveFavorites(names: newFavorites)
    }
    func listFavorites() -> [String] {
        let favorites = defaults.object(forKey: "favorites") as? [String] ?? [String]()
        return favorites
    }
}

private struct RootDictionary: Codable {
    var places: [PlaceData]
    var region: [Double]
}

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
