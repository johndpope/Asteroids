//
//  AsteroidsListDataServiceTests.swift
//  Asteroids
//
//  Created by bu on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids

class AsteroidsListDataServiceTests: XCTestCase {
    
    var sut: AsteroidsListDataService!
    var tableView: UITableView!
    var asteroidsVC: AsteroidsViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        asteroidsVC = storyboard.instantiateViewController(withIdentifier: "AsteroidsListVC") as! AsteroidsViewController
        _ = asteroidsVC.view
        
        sut = AsteroidsListDataService()
        sut.asteroidManager = AsteroidManager()
        
        tableView = asteroidsVC.asteroidsListTableView
        
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRowCount_ShouldEqualAsteroidsCount() {
        sut.asteroidManager?.addAsteroid(asteroid: Asteroid(uid: "123", name: "name1", diamFeetMin: 10.5, diamFeetMax: 20, diamMetersMin: 10, diamMetersMax: 20, isDangerous: false, velocityKmH: 141.1, velocityMilesH: 100, minDistanceKm: 12345, minDistanceMiles: 1234))
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.asteroidManager?.addAsteroid(asteroid: Asteroid(uid: "456", name: "name2", diamFeetMin: 20, diamFeetMax: 30, diamMetersMin: 20, diamMetersMax: 40, isDangerous: true, velocityKmH: 145, velocityMilesH: 105, minDistanceKm: 100000, minDistanceMiles: 9999))
        
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testCellForRowAtIndexPath_ShouldReturnAsteroidCell() {
        sut.asteroidManager?.addAsteroid(asteroid: Asteroid(uid: "456", name: "name2", diamFeetMin: 20, diamFeetMax: 30, diamMetersMin: 20, diamMetersMax: 40, isDangerous: true, velocityKmH: 145, velocityMilesH: 105, minDistanceKm: 100000, minDistanceMiles: 9999))
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is AsteroidTableViewCell)
    }
    
    func testCell_ShouldDequeueCell() {
        let tableViewMock = TableViewMock.initializeTableViewMock()
        tableViewMock.dataSource = sut
        
        sut.asteroidManager?.addAsteroid(asteroid: Asteroid(uid: "456", name: "name2", diamFeetMin: 20, diamFeetMax: 30, diamMetersMin: 20, diamMetersMax: 40, isDangerous: true, velocityKmH: 145, velocityMilesH: 105, minDistanceKm: 100000, minDistanceMiles: 9999))
        tableViewMock.reloadData()
        
        _ = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(tableViewMock.cellDequeuedProperly)
    }
    
    func testCellConfig_ShouldSetCellData() {
        let tableViewMock = TableViewMock.initializeTableViewMock()
        tableViewMock.dataSource = sut
        
        let asteroid = Asteroid(uid: "456", name: "name2", diamFeetMin: 20, diamFeetMax: 30, diamMetersMin: 20, diamMetersMax: 40, isDangerous: true, velocityKmH: 145, velocityMilesH: 105, minDistanceKm: 100000, minDistanceMiles: 9999)

        sut.asteroidManager?.addAsteroid(asteroid: asteroid)
        tableViewMock.reloadData()
        
        let cell = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0)) as! AsteroidCellMock
        
        XCTAssertEqual(cell.currentAsteroidViewModel, AsteroidViewModel(asteroid: asteroid))
        
    }
    
}

