//
//  AsteroidViewModel.swift
//  Asteroids
//
//  Created by olegshamin on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation

class AsteroidViewModel: Equatable {
    private var asteroid: Asteroid
    
    var uid: String {
        return asteroid.uid
    }
    
    var nameText: String {
        return asteroid.name
    }
    
    var diameter: String {
        get {
            if Constants.system == System.metric.rawValue {
                return "\(convertToStringFrom(minDiam: asteroid.diamMetersMin, andMaxDiam: asteroid.diamMetersMax)) м"
            } else {
                return "\(convertToStringFrom(minDiam: asteroid.diamFeetMin, andMaxDiam: asteroid.diamFeetMax)) ф"
            }
        }
    }
    
    var velocity: String {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            formatter.maximumFractionDigits = 0
            if Constants.system == System.metric.rawValue {
                let velocityKmH = formatter.string(from: NSNumber(value: asteroid.velocityKmH))
                return "\(NSLocalizedString("Velocity", comment: "")): \(velocityKmH ?? ("--")) \(NSLocalizedString("kmh", comment: ""))"
            } else {
                let velocityMilesH = formatter.string(from: NSNumber(value: asteroid.velocityMilesH))
                return "\(NSLocalizedString("Velocity", comment: "")): \(velocityMilesH ?? ("--")) \(NSLocalizedString("mph", comment: ""))"
            }
        }
    }
    
    var distance: String {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            formatter.maximumFractionDigits = 0
            if Constants.system == System.metric.rawValue {
                let minDistanceKm = formatter.string(from: NSNumber(value: asteroid.minDistanceKm))
                return "Дистанция: \(minDistanceKm ?? ("--")) км"
            } else {
                let minDistanceMiles = formatter.string(from: NSNumber(value: asteroid.minDistanceMiles))
                return "Дистанция: \(minDistanceMiles ?? ("--")) ми"
            }
        }
    }
    var isDangerous: Bool {
        return asteroid.isDangerous
    }
    
    init(asteroid: Asteroid) {
        self.asteroid = asteroid
    }
    
    func convertToStringFrom(minDiam: Double, andMaxDiam maxDiam: Double) -> String {
        let diamMaxConverted = String(format: "%.0f", maxDiam)
        let diamMinConverted = String(format: "%.0f", minDiam)
        return "Диаметр: \(diamMinConverted) - \(diamMaxConverted)"
    }
    
    static func == (lhs: AsteroidViewModel, rhs: AsteroidViewModel) -> Bool {
        if lhs.uid != rhs.uid {
            return false
        }
        return true
    }
}
