//
//  OrbitalManager.swift
//  Asteroids
//
//  Created by olegshamin on 27/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OrbitalManager {
    weak var delegate: OrbitalManagerDelegate?
    
    func getOrbitDetail(asteroidUid: String) {
        
        Alamofire.request("\(Constants.apiGetAsteroid)/\(asteroidUid)?api_key=\(Constants.apiKey)").responseJSON { response in
            print(response.result)   // result of response serialization
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let orbitalData = json["orbital_data"].dictionaryObject as! [String: String]
                
                if orbitalData.count > 0 {
                    self.delegate?.handleOrbitalDataResults(asteroidOrbitalData: orbitalData)
                } else {
                    //get error
                    self.delegate?.handleErrorWithMessage(errorMessage: json["error_message"].stringValue)
                }
            case .failure(let error):
                self.delegate?.handleErrorWithMessage(errorMessage: error.localizedDescription)
            }
        }
    }
}
