//
//  OrbitalDataTableViewCell.swift
//  Asteroids
//
//  Created by bu on 27/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class OrbitalDataTableViewCell: UITableViewCell {

    @IBOutlet weak var parameterKeyLabel: UILabel!
    @IBOutlet weak var parameterValueLabel: UILabel!
    
    func configureCellWithParameter(orbitalParameter: [String: String]) {
        for (key,value) in orbitalParameter {
            parameterKeyLabel.text = key
            parameterValueLabel.text = value
        }
    }

}
