//
//  SearchDataService.swift
//  Asteroids
//
//  Created by olegshamin on 05/07/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class SearchDataService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var searchManager: SearchManager?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let searchManager = searchManager else {return 0}
    
        return searchManager.asteroidsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "asteroidsList", for: indexPath) as! AsteroidTableViewCell

        guard let searchManager = searchManager else { fatalError() }

        guard let currentAsteroid = searchManager.getAsteroidAtIndex(index: indexPath.row) else {return cell}

        cell.configureCellWith(asteroidViewModel: AsteroidViewModel(asteroid: currentAsteroid))
        
        return cell
    }
}
