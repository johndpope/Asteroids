//
//  AsteroidCellTests.swift
//  Asteroids
//
//  Created by bu on 20/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids

class AsteroidCellTests: XCTestCase {
    
    var tableView: UITableView!
    var dataSource: MockCellDataSource!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let asteroidsVC = storyboard.instantiateViewController(withIdentifier: "AsteroidsListVC") as! AsteroidsViewController
        _ = asteroidsVC.view
        
        tableView = asteroidsVC.asteroidsListTableView
        dataSource = MockCellDataSource()
        tableView.dataSource = dataSource
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCellConfigure_ShouldSetLabelsToAsteroidData() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "asteroidsList", for: IndexPath(row: 0, section: 0)) as! AsteroidTableViewCell
        
        let currentAsteroid = Asteroid(uid: "123", name: "name1", diamFeetMin: 10.5, diamFeetMax: 20, diamMetersMin: 10, diamMetersMax: 20, isDangerous: false, velocityKmH: 141.1, velocityMilesH: 100, minDistanceKm: 12345, minDistanceMiles: 1234)
        
        cell.configureCellWith(asteroidViewModel: AsteroidViewModel(asteroid: currentAsteroid))
        
        if (Constants.system == System.metric.rawValue) {
            XCTAssertEqual(cell.diameterLabel.text, "Диаметр: 10 - 20 м")
            XCTAssertEqual(cell.velocityLabel.text, "Скорость: 141 км/ч")
            XCTAssertEqual(cell.distanceLabel.text, "Дистанция: 12 345 км")
        } else {
            XCTAssertEqual(cell.diameterLabel.text, "Диаметр: 10.5 - 20 ф")
            XCTAssertEqual(cell.velocityLabel.text, "Скорость: 100 миль/ч")
            XCTAssertEqual(cell.distanceLabel.text, "Дистанция: 1 234 миль")
        }
        XCTAssertEqual(cell.nameLabel.text, "name1")
    }
    
}
