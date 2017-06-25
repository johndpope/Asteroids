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
    
    var asteroidsArray1 = [Asteroid]()
    var asteroidsArray2 = [Asteroid]()
    
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
    
    
    
    func testSectionCount_ShouldEqualDatesCount() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = dateFormatter.date(from: "2017-06-22")
        let date2 = dateFormatter.date(from: "2017-06-23")
        
        sut.asteroidManager?.appendDates(dates: [date1!])
        
//        sut.asteroidManager?.addDate(date: "2017-06-22")
        XCTAssertEqual(tableView.numberOfSections, 1)

        sut.asteroidManager?.appendDates(dates: [date2!])
//        sut.asteroidManager?.addDate(date: "2017-06-23")
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfSections, 2)
    }

    func testRowCount_ShouldEqualAsteroidsForCurrentDateCount() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = dateFormatter.date(from: "2017-06-22")
        let date2 = dateFormatter.date(from: "2017-06-23")
        
        sut.asteroidManager?.appendDates(dates: [date1!,date2!])
        
//        sut.asteroidManager?.addDate(date: "2017-06-22")
//        sut.asteroidManager?.addDate(date: "2017-06-23")
        sut.asteroidManager?.addAsteroidsForDate(asteroids: asteroidsArray1, date: "2017-06-22")
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 3)
        
        sut.asteroidManager?.addAsteroidsForDate(asteroids: asteroidsArray2, date: "2017-06-23")
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
    }
    
    func testCellForRowAtIndexPath_ShouldReturnAsteroidCell() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = dateFormatter.date(from: "2017-06-22")
        
        sut.asteroidManager?.appendDates(dates: [date1!])
        
//        sut.asteroidManager?.addDate(date: "2017-06-22")
        sut.asteroidManager?.addAsteroidsForDate(asteroids: asteroidsArray1, date: "2017-06-22")
        tableView.reloadData()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is AsteroidTableViewCell)
    }
    
    func testCell_ShouldDequeueCell() {
        let tableViewMock = TableViewMock.initializeTableViewMock()
        tableViewMock.dataSource = sut
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = dateFormatter.date(from: "2017-06-22")
        sut.asteroidManager?.appendDates(dates: [date1!])
        
//        sut.asteroidManager?.addDate(date: "2017-06-22")
        sut.asteroidManager?.addAsteroidsForDate(asteroids: asteroidsArray1, date: "2017-06-22")
        tableViewMock.reloadData()
        
        _ = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(tableViewMock.cellDequeuedProperly)
    }
    
    func testCellConfig_ShouldSetCellData() {
        let tableViewMock = TableViewMock.initializeTableViewMock()
        tableViewMock.dataSource = sut

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = dateFormatter.date(from: "2017-06-22")
        sut.asteroidManager?.appendDates(dates: [date1!])
        
//        sut.asteroidManager?.addDate(date: "2017-06-22")
        sut.asteroidManager?.addAsteroidsForDate(asteroids: asteroidsArray1, date: "2017-06-22")
        tableViewMock.reloadData()
        
        let cell = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0)) as! AsteroidCellMock
        
        XCTAssertEqual(cell.currentAsteroidViewModel, AsteroidViewModel(asteroid: asteroidsArray1[0]))
        
    }
    
    func testTableViewHeaderTitles_ShouldReturnCorrectValues() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1 = dateFormatter.date(from: "2017-06-22")
        let date2 = dateFormatter.date(from: "2017-06-23")
        sut.asteroidManager?.appendDates(dates: [date1!,date2!])
        
//        sut.asteroidManager?.addDate(date: "2017-06-22")
//        sut.asteroidManager?.addDate(date: "2017-06-23")
        let section1Title = tableView.dataSource?.tableView!(tableView, titleForHeaderInSection: 0)
        let section2Title = tableView.dataSource?.tableView!(tableView, titleForHeaderInSection: 1)
        
        XCTAssertEqual(section1Title, "22.06.17")
        XCTAssertEqual(section2Title, "23.06.17")
    }
    
}

