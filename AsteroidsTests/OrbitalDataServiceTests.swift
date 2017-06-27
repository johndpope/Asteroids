//
//  OrbitalDataServiceTests.swift
//  Asteroids
//
//  Created by bu on 27/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids

class OrbitalDataServiceTests: XCTestCase {
    
    var sut: OrbitalDataService!
    var tableView: UITableView!
    var orbitalDetailVC: OrbitalDetailViewController!
    
    var testOrbitalData: [String:String] = ["orbit_id":"36",
                                                       "orbit_determination_date":"2017-06-04 06:16:52",
                                                       "aphelion_distance":"1.731152507719905",
                                                       "mean_anomaly":"3.155916920962632",
                                                       "equinox":"J2000",
                                                       "perihelion_time":"2457996.323395027522",
                                                       "orbital_period":"476.431359806929",
                                                       "inclination":"32.82909970238478",
                                                       "perihelion_distance":".6564641733475574",
                                                       "eccentricity":".4501092419457689",
                                                       "ascending_node_longitude":"77.07878812611693",
                                                       "perihelion_argument":"272.6355791644916",
                                                       "minimum_orbit_intersection":".03227",
                                                       "jupiter_tisserand_invariant":"5.077",
                                                       "epoch_osculation":"2458000.5",
                                                       "orbit_uncertainty":"0",
                                                       "semi_major_axis":"1.193808340533731",
                                                       "mean_motion":".755617766525461"]
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        orbitalDetailVC = storyboard.instantiateViewController(withIdentifier: "OrbitalDetailVC") as! OrbitalDetailViewController
        _ = orbitalDetailVC.view
        
        sut = OrbitalDataService()
        sut.orbitalManager = OrbitalManager()
        
        tableView = orbitalDetailVC.orbitalDataTableView
        
        tableView.dataSource = sut
        tableView.delegate = sut
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRowCount_ShouldEqualOrbitalDataCount() {
        sut.orbitalManager?.addOrbitalData(data: testOrbitalData)
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 18)
    }
    
    func testCellForRowAtIndexPath_ShouldReturnOrbitalDataCell() {
        sut.orbitalManager?.addOrbitalData(data: testOrbitalData)
        tableView.reloadData()

        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is OrbitalDataTableViewCell)
    }
    
    func testCell_ShouldDequeueCell() {
        let tableViewMock = TableViewMock.initializeTableViewMock()
        tableViewMock.dataSource = sut
        
        sut.orbitalManager?.addOrbitalData(data: testOrbitalData)

        tableViewMock.reloadData()
        
        _ = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(tableViewMock.cellDequeuedProperly)
    }
    
    func testCellConfig_ShouldSetCellData() {
        let tableViewMock = TableViewMock.initializeTableViewMock()
        tableViewMock.dataSource = sut
        
        sut.orbitalManager?.addOrbitalData(data: testOrbitalData)

        tableViewMock.reloadData()
        
        let cell = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0)) as! OrbitalDataCellMock
        
        let orbitalParameter = sut.orbitalManager?.getOrbitalParameterAtIndex(index: 0)
        
        XCTAssertEqual(cell.orbitalParameter!, orbitalParameter!)
        
    }
    
}
