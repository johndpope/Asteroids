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
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var asteroidImageView: UIImageView!
    var isLoading = true
    
    var asteroidManager: AsteroidManager = AsteroidManager()
    
    //MARK: - View Controller Lifecycle
    
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
        zoomInAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        asteroidsListTableView.reloadData()
    }
    
    //MARK: - Handle request results
    func handleResult() {
        isLoading = false
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
                let asteroidName = asteroid?.name ?? ""
                vc.asteroidUid = asteroidUid
                vc.asteroidDate = date
                vc.asteroidName = asteroidName
            }
        }
    }
    
    //MARK: - splash animation
    func zoomInAnimation() {
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
            self.asteroidImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            self.asteroidImageView.center = self.view.center
        }, completion: {
            (value: Bool) in
            if !self.isLoading {
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                    self.asteroidImageView.frame = CGRect(x: 0, y: 0, width: 600, height: 600)
                    self.asteroidImageView.center = self.view.center
                }, completion: {
                    (value: Bool) in
                    self.loadingView.isHidden = true
                })
            } else {
                self.zoomOutAnimation()
            }
        })
    }
    
    func zoomOutAnimation() {
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
            self.asteroidImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.asteroidImageView.center = self.view.center
        }, completion: {
            (value: Bool) in
            self.zoomInAnimation()
        })
    }
}
