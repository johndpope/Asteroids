//
//  AsteroidManager.swift
//  Asteroids
//
//  Created by bu on 20/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation

class AsteroidManager {
    var asteroidsArrayCount: Int { return asteroidsArray.count }
    
    private var asteroidsArray = [Asteroid]()
    
    func addAsteroid(asteroid: Asteroid) {
        if !asteroidsArray.contains(asteroid) {
            asteroidsArray.append(asteroid)
        }
    }
    
    func asteroidAtIndex(index: Int) -> Asteroid {
        return asteroidsArray[index]
    }
}
