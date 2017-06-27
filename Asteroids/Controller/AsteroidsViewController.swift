//
//  AsteroidsViewController.swift
//  Asteroids
//
//  Created by olegshamin on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class AsteroidsViewController: UIViewController, AsteroidManagerDelegate {

    @IBOutlet weak var asteroidsListTableView: UITableView!
    @IBOutlet var dataService: AsteroidsListDataService!
    @IBOutlet weak var tableFooterView: UIView!
    
    var asteroidManager: AsteroidManager = AsteroidManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        asteroidManager.delegate = self
        dataService.asteroidManager = asteroidManager
        
        asteroidsListTableView.dataSource = dataService
        asteroidsListTableView.delegate = dataService
        
        asteroidsListTableView.estimatedRowHeight = 44.0
        asteroidsListTableView.rowHeight = UITableViewAutomaticDimension
        
        tableFooterView.isHidden = true
        
        //first update asteroids
        let today = Date()
        let todayPlus7 = today.dateFromDays(7)
        asteroidManager.getAsteroids(startDate: today, endDate: todayPlus7)
    }
    
    //MARK: - Handle request results
    func handleResult() {
        tableFooterView.isHidden = true
        asteroidsListTableView.reloadData()
    }
    
    func handleErrorWithMessage(errorMessage: String) {
        showAlertWithTitle("Внимание", andMessage: errorMessage)
    }
    
    //MARK: - Actions
    func showAlertWithTitle(_ title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Asteroid Detail" {
            if let vc = segue.destination as? OrbitalDetailViewController {
                let senderButton = sender as! UIButton
                let buttonPosition = senderButton.convert(CGPoint(), to:asteroidsListTableView)
                let indexPath = asteroidsListTableView.indexPathForRow(at:buttonPosition) ?? IndexPath()
                
                let date = asteroidManager.getDateAtIndex(index: indexPath.section)
                let asteroid = asteroidManager.getAsteroidAtIndexForDate(index: indexPath.row, date: date)
                let asteroidUid = asteroid?.uid ?? ""
                vc.asteroidUid = asteroidUid
                
            }
        }
    }
}
