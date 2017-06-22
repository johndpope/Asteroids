//
//  AsteroidManager.swift
//  Asteroids
//
//  Created by bu on 20/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AsteroidManager {
    var asteroidsArrayCount: Int { return asteroidsArray.count }
    var daysArrayCount: Int { return daysArray.count }
    
    private var asteroidsArray = [Asteroid]()
    private var daysArray = [String]()
    
    func addDay(day: String) {
        if !daysArray.contains(day) {
            daysArray.append(day)
        }
    }
    
    func addAsteroid(asteroid: Asteroid) {
        if !asteroidsArray.contains(asteroid) {
            asteroidsArray.append(asteroid)
        }
    }
    
    func asteroidAtIndex(index: Int) -> Asteroid {
        return asteroidsArray[index]
    }
    
    func dayForSection(index: Int) -> String {
        let dayString = convertDate(date: daysArray[index])
        return dayString
    }
    
    func convertDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date) {
            let result = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
            return result
        }
        return ""
    }
}
