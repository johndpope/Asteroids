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
