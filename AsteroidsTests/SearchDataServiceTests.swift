//
//  SearchDataServiceTests.swift
//  Asteroids
//
//  Created by olegshamin on 05/07/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids

class SearchDataServiceTests: XCTestCase {
    
    var sut: SearchDataService!
    var tableView: UITableView!
    var searchVC: SearchViewController!

    let asteroid1 = Asteroid(uid: "001", name: "name1", diamFeetMin: 10, diamFeetMax: 20, diamMetersMin: 15, diamMetersMax: 25, isDangerous: true, velocityKmH: 100, velocityMilesH: 60, minDistanceKm: 100000, minDistanceMiles: 9999)
    let asteroid2 = Asteroid(uid: "002", name: "name2", diamFeetMin: 10, diamFeetMax: 20, diamMetersMin: 15, diamMetersMax: 25, isDangerous: true, velocityKmH: 100, velocityMilesH: 60, minDistanceKm: 100000, minDistanceMiles: 9999)
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        searchVC = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchViewController
        _ = searchVC.view
        
        sut = SearchDataService()
        sut.searchManager = SearchManager()
        
        tableView = searchVC.asteroidsTableView
        
        tableView.dataSource = sut
        tableView.delegate = sut

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRowCount_ShouldEqualAsteroidsCount() {
        sut.searchManager?.addAsteroid(asteroid: asteroid1)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.searchManager?.addAsteroid(asteroid: asteroid2)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testCellForRowAtIndexPath_ShouldReturnAsteroidCell() {

        sut.searchManager?.addAsteroid(asteroid: asteroid1)
        
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is AsteroidTableViewCell)
    }
    
    func testCell_ShouldDequeueCell() {
        let tableViewMock = TableViewMock.initializeTableViewMock()
        tableViewMock.dataSource = sut
        
        sut.searchManager?.addAsteroid(asteroid: asteroid1)

        tableViewMock.reloadData()
        
        _ = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(tableViewMock.cellDequeuedProperly)
    }
    
    func testCellConfig_ShouldSetCellData() {
        let tableViewMock = TableViewMock.initializeTableViewMock()
        tableViewMock.dataSource = sut
        
        sut.searchManager?.addAsteroid(asteroid: asteroid1)

        tableViewMock.reloadData()
        
        let cell = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0)) as! AsteroidCellMock
        
        XCTAssertEqual(cell.currentAsteroidViewModel, AsteroidViewModel(asteroid: asteroid1))
        
    }
    
}
