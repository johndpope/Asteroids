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
    var lastDateInArray: String { return self.dateArray.last ?? "" }
    var firstDateInArray: String { return self.dateArray.first ?? "" }
    
    private var dateArray = [String]()
    private var asteroids = Dictionary<String, [Asteroid]>()
    weak var delegate: AsteroidManagerDelegate?
    
    func appendDates(dates: [Date]) {
        var datesStrArray = [String]()
        for date in dates {
            let dateStr = convertDateToDateString(date: date)
            datesStrArray.append(dateStr)
        }
        dateArray.append(contentsOf: datesStrArray)
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
    
    //MARK: - Requests
    
    func getAsteroids(startDate: Date, endDate: Date) {
        
        //get array from dates range
        let dates = generateDays(startDate, endDate: endDate)
    
        appendDates(dates: dates)

        var datesStrArray = [String]()
        
        //set self.dateArrayString
        for date in dates {
            let dateString = convertDateToDateString(date: date)
            datesStrArray.append(dateString)
        }
        
        //convert startDate and endDate to string
        let startDateStr = convertDateToDateString(date: startDate)
        let endDateStr = convertDateToDateString(date: endDate)
        
        Alamofire.request("\(Constants.apiGetAsteroidsList)?start_date=\(startDateStr)&end_date=\(endDateStr)&detailed=false&api_key=\(Constants.apiKey)").responseJSON { response in
            print(response.result)   // result of response serialization
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let countOfElements = json[JsonKeys.element_count.rawValue].intValue
                
                if countOfElements > 0 {
                    var asteroidsArray = [Asteroid]()
                    
                    //for all dates in array get current Asteroid and add to Array
                    for i in 0 ..< datesStrArray.count {
                        let dateStr = datesStrArray[i]
                        
                        //asteroids for current day
                        let asteroidsByDay = json[JsonKeys.near_earth_objects.rawValue][dateStr]
                        
                        if asteroidsByDay.count > 0 {
                            
                            for i in 0 ..< asteroidsByDay.count {
                                
                                let asteroid = Asteroid(uid: asteroidsByDay[i][JsonKeys.neo_reference_id.rawValue].stringValue,
                                                        name: asteroidsByDay[i][JsonKeys.name.rawValue].stringValue,
                                                        diamFeetMin: asteroidsByDay[i][JsonKeys.estimated_diameter.rawValue][JsonKeys.feet.rawValue][JsonKeys.estimated_diameter_min.rawValue].doubleValue,
                                                        diamFeetMax: asteroidsByDay[i][JsonKeys.estimated_diameter.rawValue][JsonKeys.feet.rawValue][JsonKeys.estimated_diameter_max.rawValue].doubleValue,
                                                        diamMetersMin: asteroidsByDay[i][JsonKeys.estimated_diameter.rawValue][JsonKeys.meters.rawValue][JsonKeys.estimated_diameter_min.rawValue].doubleValue,
                                                        diamMetersMax: asteroidsByDay[i][JsonKeys.estimated_diameter.rawValue][JsonKeys.meters.rawValue][JsonKeys.estimated_diameter_max.rawValue].doubleValue,
                                                        isDangerous: asteroidsByDay[i][JsonKeys.is_potentially_hazardous_asteroid.rawValue].boolValue,
                                                        velocityKmH: asteroidsByDay[i][JsonKeys.close_approach_data.rawValue][0][JsonKeys.relative_velocity.rawValue][JsonKeys.kilometers_per_hour.rawValue].doubleValue,
                                                        velocityMilesH: asteroidsByDay[i][JsonKeys.close_approach_data.rawValue][0][JsonKeys.relative_velocity.rawValue][JsonKeys.miles_per_hour.rawValue].doubleValue,
                                                        minDistanceKm: asteroidsByDay[i][JsonKeys.close_approach_data.rawValue][0][JsonKeys.miss_distance.rawValue][JsonKeys.kilometers.rawValue].doubleValue,
                                                        minDistanceMiles: asteroidsByDay[i][JsonKeys.close_approach_data.rawValue][0][JsonKeys.miss_distance.rawValue][JsonKeys.miles.rawValue].doubleValue)
                                asteroidsArray.append(asteroid)
                            }
                            self.asteroids[dateStr] = asteroidsArray
                            asteroidsArray.removeAll()
                        }
                    }
                    self.delegate?.handleResult(asteroids: self.asteroids)
                } else {
                    //get error
                    self.delegate?.handleErrorWithMessage(errorMessage: json["error_message"].stringValue)
                }
            case .failure(let error):
                self.delegate?.handleErrorWithMessage(errorMessage: error.localizedDescription)
            }
        }
    }
    
    //MARK: - Helpers for Date
    func dateForSection(index: Int) -> String {
        if dateArrayCount <= index {
            return ""
        }
        let dateString = convertDateFormat(date: dateArray[index])
        return dateString
    }
    
    private func convertDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date) {
            let result = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
            return result
        }
        return ""
    }
    
    func convertDateStringToDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: string) {
            return date
        }
        return nil
    }
    
    private func convertDateToDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func generateDays(_ beginDate: Date, endDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = beginDate
        
        while date.compare(endDate) != .orderedDescending {
            dates.append(date)
            date = date.dateFromDays(1)
        }
        return dates
    }
}
