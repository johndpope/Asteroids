//
//  OrbitalDataCellTests.swift
//  Asteroids
//
//  Created by bu on 27/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids
class OrbitalDataCellTests: XCTestCase {
    
    var tableView: UITableView!
    var dataSource: MockCellDataSource!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let orbitalDetailVC = storyboard.instantiateViewController(withIdentifier: "OrbitalDetailVC") as! OrbitalDetailViewController
        _ = orbitalDetailVC.view
        
        tableView = orbitalDetailVC.orbitalDataTableView
        dataSource = MockCellDataSource()
        tableView.dataSource = dataSource
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCellConfigure_ShouldSetLabelsToAsteroidData() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orbitalDataCell", for: IndexPath(row: 0, section: 0)) as! OrbitalDataTableViewCell
        
        cell.configureCellWithParameter(orbitalParameter: ["orbit_id":"36"])
        
        XCTAssertEqual(cell.parameterKeyLabel.text, "orbit_id")
        XCTAssertEqual(cell.parameterValueLabel.text, "36")
    }
    
}
