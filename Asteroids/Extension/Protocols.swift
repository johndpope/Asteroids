//
//  Protocols.swift
//  Asteroids
//
//  Created by olegshamin on 27/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation

protocol AsteroidManagerDelegate: class {
    func handleResult(asteroids: Dictionary<String, [Asteroid]>)
    func handleErrorWithMessage(errorMessage: String)
}

protocol OrbitalManagerDelegate: class {
    func handleOrbitalDataResults(asteroidOrbitalData: Dictionary<String, String>)
    func handleErrorWithMessage(errorMessage: String)
}
