//
//  AsteroidManagerTests.swift
//  Asteroids
//
//  Created by bu on 20/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids

class AsteroidManagerTests: XCTestCase {
    
    var sut: AsteroidManager!
    
    override func setUp() {
        super.setUp()
        
        sut = AsteroidManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsteroidsArrayCount_ReturnsZero() {
        XCTAssertEqual(sut.asteroidsArrayCount, 0)
    }
    
    func testAsteroidsArrayCount_ShouldBeOneAfterAsteroidAdded() {
        sut.addAsteroid(asteroid: Asteroid(uid: "456", name: "name2", diamFeetMin: 20, diamFeetMax: 30, diamMetersMin: 20, diamMetersMax: 40, isDangerous: true, velocityKmH: 145, velocityMilesH: 105, minDistanceKm: 100000, minDistanceMiles: 9999))
        XCTAssertEqual(sut.asteroidsArrayCount, 1)
    }
    
    func testAsteroidAtIndex_ReturnsLastAddedAsteroid() {
        let asteroid = Asteroid(uid: "456", name: "name2", diamFeetMin: 20, diamFeetMax: 30, diamMetersMin: 20, diamMetersMax: 40, isDangerous: true, velocityKmH: 145, velocityMilesH: 105, minDistanceKm: 100000, minDistanceMiles: 9999)
        sut.addAsteroid(asteroid: asteroid)
        
        let returnedAsteroidAtIndex = sut.asteroidAtIndex(index: 0)
        XCTAssertEqual(asteroid, returnedAsteroidAtIndex)
    }
    
    func testAddingDuplicateAsteroid_ShouldNotAddToAsteroidsArray() {
        let asteroid1 = Asteroid(uid: "456", name: "name2", diamFeetMin: 20, diamFeetMax: 30, diamMetersMin: 20, diamMetersMax: 40, isDangerous: true, velocityKmH: 145, velocityMilesH: 105, minDistanceKm: 100000, minDistanceMiles: 9999)
        let asteroid2 = Asteroid(uid: "456", name: "name2", diamFeetMin: 20, diamFeetMax: 30, diamMetersMin: 20, diamMetersMax: 40, isDangerous: true, velocityKmH: 145, velocityMilesH: 105, minDistanceKm: 100000, minDistanceMiles: 9999)
        
        sut.addAsteroid(asteroid: asteroid1)
        sut.addAsteroid(asteroid: asteroid2)
        
        XCTAssertEqual(sut.asteroidsArrayCount, 1)
    }
    
    func testConvertDateFormat_ShouldEqualLocalDateFormat() {
        var date = "2017-06-24"
        var convertedDate = sut.convertDate(date: date)
        XCTAssertEqual(convertedDate, "24.06.17")
        
        date = "hui"
        convertedDate = sut.convertDate(date: date)
        XCTAssertEqual(convertedDate, "")
        
        date = "2017-13-24"
        convertedDate = sut.convertDate(date: date)
        XCTAssertEqual(convertedDate, "")
        
        date = "2017-02-31"
        convertedDate = sut.convertDate(date: date)
        XCTAssertEqual(convertedDate, "")
    }

    
}
