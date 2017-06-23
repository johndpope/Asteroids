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
    var asteroidsArray1 = [Asteroid]()
    var asteroidsArray2 = [Asteroid]()
    
    override func setUp() {
        super.setUp()
        
        sut = AsteroidManager()
        
        //generate tests data
        let asteroid1 = Asteroid(uid: "001", name: "name1", diamFeetMin: 10, diamFeetMax: 20, diamMetersMin: 15, diamMetersMax: 25, isDangerous: true, velocityKmH: 100, velocityMilesH: 60, minDistanceKm: 100000, minDistanceMiles: 9999)
        let asteroid2 = Asteroid(uid: "002", name: "name2", diamFeetMin: 10, diamFeetMax: 20, diamMetersMin: 15, diamMetersMax: 25, isDangerous: true, velocityKmH: 100, velocityMilesH: 60, minDistanceKm: 100000, minDistanceMiles: 9999)
        let asteroid3 = Asteroid(uid: "003", name: "name3", diamFeetMin: 10, diamFeetMax: 20, diamMetersMin: 15, diamMetersMax: 25, isDangerous: true, velocityKmH: 100, velocityMilesH: 60, minDistanceKm: 100000, minDistanceMiles: 9999)
        let asteroid4 = Asteroid(uid: "004", name: "name4", diamFeetMin: 10, diamFeetMax: 20, diamMetersMin: 15, diamMetersMax: 25, isDangerous: true, velocityKmH: 100, velocityMilesH: 60, minDistanceKm: 100000, minDistanceMiles: 9999)
        
        asteroidsArray1 = [asteroid1, asteroid2, asteroid3]
        asteroidsArray2 = [asteroid4]
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDateArrayCount_ReturnsZero() {
        XCTAssertEqual(sut.dateArrayCount, 0)
    }
    
    func testAddDate_CountShouldChangeAfterDateAdded() {
        sut.addDate(date: "2017-05-22")
        XCTAssertEqual(sut.dateArrayCount, 1)
        sut.addDate(date: "2017-05-23")
        XCTAssertEqual(sut.dateArrayCount, 2)
    }
    
    func testGetAsteroidsArrayCountForCurrentDate_ShouldReturnsZero() {
        XCTAssertEqual(sut.getAsteroidsArrayCountForCurrentDate(date: ""), 0)
    }
    
    func testGetAsteroidsArrayCountForCurrentDate_ShouldChangeAfterAsteroidsAdded() {
        sut.addAsteroidsForDate(asteroids: asteroidsArray1, date: "2017-06-22")
        XCTAssertEqual(sut.getAsteroidsArrayCountForCurrentDate(date: "2017-06-22"), 3)
        sut.addAsteroidsForDate(asteroids: asteroidsArray2, date: "2017-06-23")
        XCTAssertEqual(sut.getAsteroidsArrayCountForCurrentDate(date: "2017-06-23"), 1)
    }
    
    func testGetAsteroidsForDate_ShouldReturnArrayWithAsteroids() {
        sut.addAsteroidsForDate(asteroids: asteroidsArray1, date: "2017-06-22")
        sut.addAsteroidsForDate(asteroids: asteroidsArray2, date: "2017-06-23")
        
        var asteroidsForCurrentDate = sut.getAsteroidsArrayForDate(date: "2017-06-22")
        XCTAssertEqual(asteroidsForCurrentDate, asteroidsArray1)
        
        asteroidsForCurrentDate = sut.getAsteroidsArrayForDate(date: "2017-06-23")
        XCTAssertEqual(asteroidsForCurrentDate, asteroidsArray2)
        
        asteroidsForCurrentDate = sut.getAsteroidsArrayForDate(date: "")
        XCTAssertEqual(asteroidsForCurrentDate.count, 0)

    }
    
    func testGetAsteroidForIndexPathForDate_ShouldReturnAsteroidForCurrentIndexPathAndDate() {
        sut.addAsteroidsForDate(asteroids: asteroidsArray1, date: "2017-06-22")
        sut.addAsteroidsForDate(asteroids: asteroidsArray2, date: "2017-06-23")
        
        var asteroid = sut.getAsteroidAtIndexForDate(index: 0, date: "2017-06-22")
        XCTAssertEqual(asteroid, asteroidsArray1[0])
        asteroid = sut.getAsteroidAtIndexForDate(index: 2, date: "2017-06-22")
        XCTAssertEqual(asteroid, asteroidsArray1[2])
        asteroid = sut.getAsteroidAtIndexForDate(index: 0, date: "2017-06-23")
        XCTAssertEqual(asteroid, asteroidsArray2[0])
        
        XCTAssertTrue((sut.getAsteroidAtIndexForDate(index: 5, date: "2017-06-23") == nil))
        
    }
    
    func testGetDateAtIndex_ShouldReturnDateString() {
        sut.addDate(date: "2017-05-22")
        sut.addDate(date: "2017-05-23")
        var date = sut.getDateAtIndex(index: 0)
        XCTAssertEqual(date, "2017-05-22")
        date = sut.getDateAtIndex(index: 1)
        XCTAssertEqual(date, "2017-05-23")
        
        date = sut.getDateAtIndex(index: 5)
        XCTAssertEqual(date, "")
    }
    
    func testDateForSection_ShouldReturnConvertedDate() {
        sut.addDate(date: "2017-05-22")
        sut.addDate(date: "2017-05-23")
        sut.addDate(date: "2017-05-33")
        var dateForSection = sut.dateForSection(index: 0)
        XCTAssertEqual(dateForSection, "22.05.17")
        
        dateForSection = sut.dateForSection(index: 1)
        XCTAssertEqual(dateForSection, "23.05.17")
        
        dateForSection = sut.dateForSection(index: 2)
        XCTAssertEqual(dateForSection, "")
        
        dateForSection = sut.dateForSection(index: 5)
        XCTAssertEqual(dateForSection, "")
    }
    
}
