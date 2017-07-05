//
//  MockExtensions.swift
//  Asteroids
//
//  Created by bu on 20/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation
import UIKit
@testable import Asteroids

extension SearchDataServiceTests {
    class TableViewMock: UITableView {
        var cellDequeuedProperly: Bool = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellDequeuedProperly = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func initializeTableViewMock() -> TableViewMock {
            let tableViewMock = TableViewMock(frame: CGRect.init(x: 0, y: 0, width: 300, height: 500), style: .plain)
            tableViewMock.register(AsteroidCellMock.self, forCellReuseIdentifier: "asteroidsList")
            
            return tableViewMock
        }
    }
    
    class AsteroidCellMock: AsteroidTableViewCell {
        var currentAsteroidViewModel: AsteroidViewModel?
        
        override func configureCellWith(asteroidViewModel: AsteroidViewModel) {
            currentAsteroidViewModel = asteroidViewModel
        }
    }
}

extension AsteroidsListDataServiceTests {
    class TableViewMock: UITableView {
        var cellDequeuedProperly: Bool = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellDequeuedProperly = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func initializeTableViewMock() -> TableViewMock {
            let tableViewMock = TableViewMock(frame: CGRect.init(x: 0, y: 0, width: 300, height: 500), style: .plain)
            tableViewMock.register(AsteroidCellMock.self, forCellReuseIdentifier: "asteroidsList")
            
            return tableViewMock
        }
    }
    
    class AsteroidCellMock: AsteroidTableViewCell {
        var currentAsteroidViewModel: AsteroidViewModel?
        
        override func configureCellWith(asteroidViewModel: AsteroidViewModel) {
            currentAsteroidViewModel = asteroidViewModel
        }
    }
}

extension AsteroidCellTests {
    class MockCellDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}

extension OrbitalDataServiceTests {
    class TableViewMock: UITableView {
        var cellDequeuedProperly: Bool = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellDequeuedProperly = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func initializeTableViewMock() -> TableViewMock {
            let tableViewMock = TableViewMock(frame: CGRect.init(x: 0, y: 0, width: 300, height: 500), style: .plain)
            tableViewMock.register(OrbitalDataCellMock.self, forCellReuseIdentifier: "orbitalDataCell")
            
            return tableViewMock
        }
    }
    
    class OrbitalDataCellMock: OrbitalDataTableViewCell {
        var orbitalParameter: [String: String]?
        override func configureCellWithParameter(orbitalParameter: [String: String]) {
            self.orbitalParameter = orbitalParameter
        }

    }
}

extension OrbitalDataCellTests {
    class MockCellDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
