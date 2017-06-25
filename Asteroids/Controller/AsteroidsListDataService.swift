//
//  AsteroidsListDataService.swift
//  Asteroids
//
//  Created by bu on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class AsteroidsListDataService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var asteroidsTableView: UITableView!
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView is UITableView {
            let top: CGFloat = 0
            let bottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
            let buffer: CGFloat = 2 * 125
            let scrollPosition = scrollView.contentOffset.y
            
            // Reached the bottom of the list
            if scrollPosition > bottom - buffer {
                // Add more dates to the bottom
                
                guard let lastDate = asteroidManager?.convertDateStringToDate(string: (asteroidManager?.lastDateInArray)!) else {return}
                
                let startDate = lastDate.dateFromDays(1)
                let endDate = lastDate.dateFromDays(7)
                
                asteroidManager?.getAsteroids(startDate: startDate, endDate: endDate)

                print("mmmm \(String(describing: asteroidManager?.dateArrayCount))")
            }
                // Reach the top of the list
            else if scrollPosition < top + buffer {
                // Add more dates to the top
                guard let firstDate = asteroidManager?.convertDateStringToDate(string: (asteroidManager?.firstDateInArray)!) else {return}

                let startDate = firstDate.dateFromDays(-7)
                let endDate = firstDate.dateFromDays(-1)
                
                asteroidManager?.getAsteroids(startDate: startDate, endDate: endDate)

//                asteroidsTableView.contentOffset.y += 7 * 125
                asteroidsTableView.scrollToRow(at: IndexPath(row: 0, section: 7), at: UITableViewScrollPosition.top, animated: false)
                print("mmmm \(String(describing: asteroidManager?.dateArrayCount))")
            }
        }
    }
}
