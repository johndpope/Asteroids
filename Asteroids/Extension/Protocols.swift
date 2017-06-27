//
//  Protocols.swift
//  Asteroids
//
//  Created by olegshamin on 27/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation

protocol AsteroidManagerDelegate: class {
    func handleResult()
    func handleErrorWithMessage(errorMessage: String)
}

protocol OrbitalManagerDelegate: class {
    func handleOrbitalDataResults()
    func handleErrorWithMessage(errorMessage: String)
}
