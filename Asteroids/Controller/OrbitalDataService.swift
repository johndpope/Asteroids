//
//  OrbitalDataService.swift
//  Asteroids
//
//  Created by olegshamin on 27/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class OrbitalDataService: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var orbitalManager: OrbitalManager?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let orbitalManager = orbitalManager else {return 0}
        
        return orbitalManager.dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orbitalDataCell", for: indexPath) as! OrbitalDataTableViewCell
        
        guard let orbitalManager = orbitalManager else { fatalError() }
        
        let orbitalParameter = orbitalManager.getOrbitalParameterAtIndex(index: indexPath.row)
        cell.configureCellWithParameter(orbitalParameter: orbitalParameter)
        
        return cell
    }
    
}
