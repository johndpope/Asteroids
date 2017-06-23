//
//  Constants.swift
//  Asteroids
//
//  Created by olegshamin on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation

struct Constants {
    static let apiKey = "P2IXOQjycpTCmQkAsIofUoxaVN0B7Zg64lJAGPHh"
    static let apiGetAsteroidsList = "https://api.nasa.gov/neo/rest/v1/feed"
    
    static var system: String {
        get {
            return UserDefaults.standard.object(forKey: "settingsMetric") as? String ?? System.metric.rawValue
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "settingsMetric")
            defaults.synchronize()
        }
    }
}

enum System: String {
    case metric
    case imperial
}

enum JsonKeys: String {
    case near_earth_objects, estimated_diameter, kilometers, feet, meters, miles, estimated_diameter_min, estimated_diameter_max, kilometers_per_hour, miles_per_hour, neo_reference_id, name, is_potentially_hazardous_asteroid, close_approach_data, relative_velocity, miss_distance, element_count
}
