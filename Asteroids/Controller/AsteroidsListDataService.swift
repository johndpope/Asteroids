//
//  AsteroidsListDataService.swift
//  Asteroids
//
//  Created by bu on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class AsteroidsListDataService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var asteroidManager: AsteroidManager?

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let asteroidManager = asteroidManager else {return 1}
        return asteroidManager.daysArrayCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let asteroidManager = asteroidManager else {return 0}
        return asteroidManager.asteroidsArrayCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "asteroidsList", for: indexPath) as! AsteroidTableViewCell
        
        guard let asteroidManager = asteroidManager else { fatalError() }

        let currentAsteroid = asteroidManager.asteroidAtIndex(index: indexPath.row)
        
        cell.configureCellWith(asteroidViewModel: AsteroidViewModel(asteroid: currentAsteroid))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let asteroidManager = asteroidManager else { return "" }
        return asteroidManager.dayForSection(index: section)
    }
    
}
