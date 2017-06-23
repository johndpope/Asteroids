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
    var dateArrayCount: Int { return dateArray.count }
    
    private var dateArray = [String]()
    private var asteroids = Dictionary<String, [Asteroid]>()
    
    func addDate(date: String) {
        if !dateArray.contains(date) {
            dateArray.append(date)
        }
    }
    
    func addAsteroidsForDate(asteroids: [Asteroid], date: String) {
        self.asteroids[date] = asteroids
    }
    
    func getAsteroidsArrayForDate(date: String) -> [Asteroid] {
        guard let asteroidsArrayForDate = self.asteroids[date] else {return [Asteroid]()}
        return asteroidsArrayForDate
    }
    
    func getAsteroidsArrayCountForCurrentDate(date: String) -> Int {
        guard let asteroidsArrayForDate = self.asteroids[date] else {return 0}
        return asteroidsArrayForDate.count
    }
    
    func getAsteroidAtIndexForDate(index: Int, date: String) -> Asteroid? {
        guard let asteroidsArrayForDate = self.asteroids[date] else {return nil}
        if asteroidsArrayForDate.count <= index {
            return nil
        }
        return asteroidsArrayForDate[index]
    }
    
    func getDateAtIndex(index: Int) -> String {
        if dateArrayCount <= index {
            return ""
        }
        return self.dateArray[index]
    }
    
    func dateForSection(index: Int) -> String {
        if dateArrayCount <= index {
            return ""
        }
        let dateString = convertDate(date: dateArray[index])
        return dateString
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
