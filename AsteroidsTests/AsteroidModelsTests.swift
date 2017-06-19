//
//  AsteroidModelsTests.swift
//  Asteroids
//
//  Created by olegshamin on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids

class AsteroidModelsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsteroidViewModel() {
        let someAsteroid = Asteroid(uid: "123", name: "asteroid", diamFeetMin: 10.1, diamFeetMax: 20.1, diamMetersMin: 5.1, diamMetersMax: 10.1, isDangerous: true, velocityKmH: 100.5, velocityMilesH: 60.5, minDistanceKm: 100.75, minDistanceMiles: 50.35)
        let someAsteroidViewModel = AsteroidViewModel(asteroid: someAsteroid)
        
        if (Constants.system == System.metric.rawValue) {
            XCTAssertEqual(someAsteroidViewModel.diameter, "5.10 - 10.10 м")
            XCTAssertEqual(someAsteroidViewModel.velocity, "100 км/ч")
            XCTAssertEqual(someAsteroidViewModel.distance, "101 км")
        } else {
            XCTAssertEqual(someAsteroidViewModel.diameter, "10.1 - 20.1 ф")
            XCTAssertEqual(someAsteroidViewModel.velocity, "60 миль/ч")
            XCTAssertEqual(someAsteroidViewModel.distance, "50 миль")
        }
        
        XCTAssertEqual(someAsteroidViewModel.nameText, "asteroid")
        XCTAssertEqual(someAsteroidViewModel.isDangerous, true)
    }
    
}
