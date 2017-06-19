//
//  AsteroidsViewControllerTests.swift
//  Asteroids
//
//  Created by bu on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids

class AsteroidsViewControllerTests: XCTestCase {
    
    var sut: AsteroidsViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "AsteroidsListVC") as! AsteroidsViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsteroidsVC_TableViewShouldNotBeNil() {
        XCTAssertNotNil(sut.asteroidsListTableView)
    }
    
    func testViewDidLoad_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.asteroidsListTableView.dataSource)
        XCTAssertTrue(sut.asteroidsListTableView.dataSource is AsteroidsListDataService)
    }
    
    func testViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(sut.asteroidsListTableView.delegate)
        XCTAssertTrue(sut.asteroidsListTableView.delegate is AsteroidsListDataService)
    }
    
    func testViewDidLoad_SetsTableViewDataSourceAndDelegateToSameObject() {
        XCTAssertEqual(sut.asteroidsListTableView.dataSource as! AsteroidsListDataService, sut.asteroidsListTableView.delegate as! AsteroidsListDataService)
    }
    
}
