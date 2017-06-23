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
        return asteroidManager.dateArrayCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let asteroidManager = asteroidManager else {return 0}
        
        let date = asteroidManager.getDateAtIndex(index: section)
        
        return asteroidManager.getAsteroidsArrayCountForCurrentDate(date: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "asteroidsList", for: indexPath) as! AsteroidTableViewCell
        
        guard let asteroidManager = asteroidManager else { fatalError() }

        let date = asteroidManager.getDateAtIndex(index: indexPath.section)
        guard let currentAsteroid = asteroidManager.getAsteroidAtIndexForDate(index: indexPath.row, date: date) else {return cell}
        
        cell.configureCellWith(asteroidViewModel: AsteroidViewModel(asteroid: currentAsteroid))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let asteroidManager = asteroidManager else { return "" }
        return asteroidManager.dateForSection(index: section)
    }
    
}
