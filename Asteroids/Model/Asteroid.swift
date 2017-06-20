//
//  Asteroid.swift
//  Asteroids
//
//  Created by olegshamin on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation

class Asteroid: Equatable {
    
    let uid: String
    let name: String
    let diamFeetMin: Double
    let diamFeetMax: Double
    let diamMetersMin: Double
    let diamMetersMax: Double
    let isDangerous: Bool
    let velocityKmH: Double
    let velocityMilesH: Double
    let minDistanceKm: Double
    let minDistanceMiles: Double
    
    init(uid: String,
         name: String,
         diamFeetMin: Double,
         diamFeetMax: Double,
         diamMetersMin: Double,
         diamMetersMax: Double,
         isDangerous: Bool,
         velocityKmH: Double,
         velocityMilesH: Double,
         minDistanceKm: Double,
         minDistanceMiles: Double) {
        
        self.uid = uid
        self.name = name
        self.diamFeetMin = diamFeetMin
        self.diamFeetMax = diamFeetMax
        self.diamMetersMin = diamMetersMin
        self.diamMetersMax = diamMetersMax
        self.isDangerous = isDangerous
        self.velocityKmH = velocityKmH
        self.velocityMilesH = velocityMilesH
        self.minDistanceKm = minDistanceKm
        self.minDistanceMiles = minDistanceMiles
    }
    
    static func == (lhs: Asteroid, rhs: Asteroid) -> Bool {
        if lhs.uid != rhs.uid {
            return false
        }
        return true 
    }
}
