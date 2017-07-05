//
//  OrbitalDetailViewController.swift
//  Asteroids
//
//  Created by olegshamin on 27/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class OrbitalDetailViewController: UIViewController, OrbitalManagerDelegate {
    
    var asteroidUid = ""
    var asteroidName = ""
    var asteroidDate = ""
    
    var orbitalManager: OrbitalManager = OrbitalManager()
    @IBOutlet var dataService: OrbitalDataService!
    @IBOutlet weak var orbitalDataTableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orbitalManager.delegate = self
        dataService.orbitalManager = orbitalManager

        orbitalDataTableView.dataSource = dataService
        orbitalDataTableView.delegate = dataService
        
        orbitalDataTableView.estimatedRowHeight = 44.0
        orbitalDataTableView.rowHeight = UITableViewAutomaticDimension
        
        orbitalManager.getOrbitDetail(asteroidUid: asteroidUid)
    }
    
    //MARK: - Handle request results
    func handleOrbitalDataResults() {
        orbitalDataTableView.reloadData()
        activityView.isHidden = true
    }
    
    func handleErrorWithMessage(errorMessage: String) {
        showAlertWithTitle("\(NSLocalizedString("Attention", comment: ""))", andMessage: errorMessage)
    }
    
    //MARK: - Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        
        // text to share
        var text = "\(NSLocalizedString("We all die", comment: "")) \(asteroidDate) \(NSLocalizedString("from the Asteroid", comment: "")) \(asteroidName)\n\(NSLocalizedString("Orbit Information", comment: "")):\n"
        
        //get orbital data
        for i in 0 ..< orbitalManager.dataCount {
            let orbitalParameter = orbitalManager.getOrbitalParameterAtIndex(index: i)
            for (key,value) in orbitalParameter {
                text += "\(key): \(value)\n"
            }
        }
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func showAlertWithTitle(_ title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "\(NSLocalizedString("OK", comment: ""))", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
