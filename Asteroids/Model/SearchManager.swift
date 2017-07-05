//
//  SearchManager.swift
//  Asteroids
//
//  Created by olegshamin on 05/07/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchManager {
    
    var asteroidsCount: Int { return asteroids.count }
    weak var delegate: AsteroidManagerDelegate?
    private var asteroids = [Asteroid]()
    
    func addAsteroid(asteroid: Asteroid) {
        if !asteroids.contains(asteroid) {
            asteroids.append(asteroid)
        }
    }
    
    func getAsteroidAtIndex(index: Int) -> Asteroid? {
        if asteroidsCount > index && index >= 0 {
            return asteroids[index]
        }
        return nil
    }
    
    func removeAllAsteroids() {
        asteroids.removeAll()
    }
    
    //MARK: - Requests
    
    func getAsteroidsForDate(date: Date) {
        
        removeAllAsteroids()
        
        //convert date to string
        let endDateStr = convertDateToDateString(date: date)
        
        let startDate = date.dateFromDays(1)
        let startDateStr = convertDateToDateString(date: startDate)
        
        Alamofire.request("\(Constants.apiGetAsteroidsList)?start_date=\(startDateStr)&end_date=\(endDateStr)&detailed=false&api_key=\(Constants.apiKey)").responseJSON { response in
            print(response.result)   // result of response serialization
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let countOfElements = json[JsonKeys.element_count.rawValue].intValue
                
                if countOfElements > 0 {
                        //asteroids for current day
                        let asteroidsByDay = json[JsonKeys.near_earth_objects.rawValue][endDateStr]
                        
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
                                self.asteroids.append(asteroid)
                            }
                        }
                    self.delegate?.handleResult()
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
    
    private func convertDateToDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
