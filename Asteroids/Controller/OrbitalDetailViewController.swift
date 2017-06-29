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
    var orbitalManager: OrbitalManager = OrbitalManager()
    @IBOutlet var dataService: OrbitalDataService!
    @IBOutlet weak var orbitalDataTableView: UITableView!
    
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
    }
    
    func handleErrorWithMessage(errorMessage: String) {
        showAlertWithTitle("Внимание", andMessage: errorMessage)
    }
    
    //MARK: - Actions
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlertWithTitle(_ title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
