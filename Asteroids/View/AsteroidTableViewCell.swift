//
//  AsteroidTableViewCell.swift
//  Asteroids
//
//  Created by bu on 20/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class AsteroidTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var asteroidView: AsteroidView!
    @IBOutlet weak var detailButton: UIButton!
    
    func configureCellWith(asteroidViewModel: AsteroidViewModel) {
        nameLabel.text = asteroidViewModel.nameText
        distanceLabel.text = asteroidViewModel.distance
        diameterLabel.text = asteroidViewModel.diameter
        velocityLabel.text = asteroidViewModel.velocity
        
        if asteroidViewModel.isDangerous {
            asteroidView.shadowColor = UIColor(red: 255.0/255.0, green: 0.0, blue: 0.0, alpha: 1.0)
        } else {
            asteroidView.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        detailButton.isHidden = !asteroidViewModel.isDangerous
    }
}
