//
//  AsteroidsListDataService.swift
//  Asteroids
//
//  Created by bu on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class AsteroidsListDataService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableFooterView: UIView!
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
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let asteroidManager = asteroidManager else { return "" }
//        return asteroidManager.dateForSection(index: section)
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var title = ""
        if let asteroidManager = asteroidManager {
            title = asteroidManager.dateForSection(index: section)
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        headerView.backgroundColor = UIColor(red: 144.0/255.0, green: 202.0/255.0, blue: 249.0/255.0, alpha: 1.0)
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: tableView.frame.size.width - 16, height: 50))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = title
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView is UITableView {
            let bottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
            let buffer: CGFloat = 250
            let scrollPosition = scrollView.contentOffset.y
            
            tableFooterView.isHidden = false
            
            // Reached the bottom of the list
            if scrollPosition > bottom - buffer {
                // Add more dates to the bottom
                guard let lastDate = asteroidManager?.convertDateStringToDate(string: (asteroidManager?.lastDateInArray)!) else {return}
                
                let startDate = lastDate.dateFromDays(1)
                let endDate = lastDate.dateFromDays(7)
                
                asteroidManager?.getAsteroids(startDate: startDate, endDate: endDate)
            }
        }
    }
}
