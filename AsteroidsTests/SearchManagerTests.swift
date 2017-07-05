//
//  SearchManagerTests.swift
//  Asteroids
//
//  Created by olegshamin on 05/07/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids

class SearchManagerTests: XCTestCase {
    
    var sut: SearchManager!
    
    let asteroid1 = Asteroid(uid: "001", name: "name1", diamFeetMin: 10, diamFeetMax: 20, diamMetersMin: 15, diamMetersMax: 25, isDangerous: true, velocityKmH: 100, velocityMilesH: 60, minDistanceKm: 100000, minDistanceMiles: 9999)
    let asteroid2 = Asteroid(uid: "002", name: "name2", diamFeetMin: 10, diamFeetMax: 20, diamMetersMin: 15, diamMetersMax: 25, isDangerous: true, velocityKmH: 100, velocityMilesH: 60, minDistanceKm: 100000, minDistanceMiles: 9999)
    
    override func setUp() {
        super.setUp()
        
        sut = SearchManager()
        
        //generate tests data
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsteroidsCount_ReturnsZero() {
        XCTAssertEqual(sut.asteroidsCount, 0)
    }
    
    func testAddAsteroid_CountShouldChangeAfterNewAsteroidAdded() {
        sut.addAsteroid(asteroid: asteroid1)
        XCTAssertEqual(sut.asteroidsCount, 1)
        sut.addAsteroid(asteroid: asteroid2)
        XCTAssertEqual(sut.asteroidsCount, 2)
    }
    
    func testAddAsteroid_CountShouldNOTChangeAfterAddAlreadyAddedAsteroid() {
        sut.addAsteroid(asteroid: asteroid1)
        XCTAssertEqual(sut.asteroidsCount, 1)
        sut.addAsteroid(asteroid: asteroid1)
        XCTAssertEqual(sut.asteroidsCount, 1)
    }
    
    func testGetAsteroidAtIndex_ShouldReturnAsteroid() {
        sut.addAsteroid(asteroid: asteroid1)
        XCTAssertEqual(sut.getAsteroidAtIndex(index: 0), asteroid1)
    }
    
    func testGetAsteroidAtBadIndex_ShouldNOTReturnAsteroid() {
        sut.addAsteroid(asteroid: asteroid1)
        XCTAssertNotEqual(sut.getAsteroidAtIndex(index: 5), asteroid1)
        XCTAssertNotEqual(sut.getAsteroidAtIndex(index: -1), asteroid1)
    }
    
    func testRemoveAsteroids_CountShouldChangeToZeroAfterRemoving() {
        sut.addAsteroid(asteroid: asteroid1)
        sut.addAsteroid(asteroid: asteroid2)
        XCTAssertEqual(sut.asteroidsCount, 2)
        sut.removeAllAsteroids()
        XCTAssertEqual(sut.asteroidsCount, 0)
    }
}
