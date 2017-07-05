//
//  SearchViewControllerTests.swift
//  Asteroids
//
//  Created by olegshamin on 05/07/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import XCTest
@testable import Asteroids

class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchViewController
        _ = sut.view    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsteroidsVC_TableViewShouldNotBeNil() {
        XCTAssertNotNil(sut.asteroidsTableView)
    }
    
    func testViewDidLoad_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.asteroidsTableView.dataSource)
        XCTAssertTrue(sut.asteroidsTableView.dataSource is SearchDataService)
    }
    
    func testViewDidLoad_SetsTableViewDelegate() {
        XCTAssertNotNil(sut.asteroidsTableView.delegate)
        XCTAssertTrue(sut.asteroidsTableView.delegate is SearchDataService)
    }
    
    func testViewDidLoad_SetsTableViewDataSourceAndDelegateToSameObject() {
        XCTAssertEqual(sut.asteroidsTableView.dataSource as! SearchDataService, sut.asteroidsTableView.delegate as! SearchDataService)
    }
}
