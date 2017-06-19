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
    
    override func setUp() {
        super.setUp()
        
        sut = AsteroidsListDataService()
        tableView = UITableView()
        
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRowCount_ShouldEqualAsteroidsCount() {
        sut.asteroidManager
    }
    
}
