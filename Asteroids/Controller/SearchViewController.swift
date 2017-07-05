//
//  SearchViewController.swift
//  Asteroids
//
//  Created by olegshamin on 05/07/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, AsteroidManagerDelegate {

    @IBOutlet weak var asteroidsTableView: UITableView!
    @IBOutlet var dataService: SearchDataService!
    @IBOutlet weak var chooseDateButton: UIButton!
    @IBOutlet weak var activityView: UIView!
    
    var searchManager: SearchManager = SearchManager()
    
    var date = Date()
    var isShowPicker = false
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchManager.delegate = self
        dataService.searchManager = searchManager
        
        asteroidsTableView.dataSource = dataService
        asteroidsTableView.delegate = dataService
        
        asteroidsTableView.estimatedRowHeight = 44.0
        asteroidsTableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityView.isHidden = true
        asteroidsTableView.reloadData()
    }
    
    //MARK: - Handle request results
    func handleResult() {
        asteroidsTableView.reloadData()
        self.activityView.isHidden = true
    }
    
    func handleErrorWithMessage(errorMessage: String) {
        showAlertWithTitle("\(NSLocalizedString("Attention", comment: ""))", andMessage: errorMessage)
    }
    
    //MARK: - Actions
    
    @IBAction func chooseDatePressed(_ sender: UIButton) {
        var asteroidsTableFrame = asteroidsTableView.frame
        
        if isShowPicker {
            asteroidsTableFrame.origin.y -= 216
            isShowPicker = false
            searchManager.getAsteroidsForDate(date: date)
            chooseDateButton.setTitle(convertDateToDateString(date: date), for: .normal)
            self.activityView.isHidden = false
        } else {
            asteroidsTableFrame.origin.y += 216
            isShowPicker = true
            self.activityView.isHidden = true
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.asteroidsTableView.frame = asteroidsTableFrame
        })
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        date = sender.date
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Asteroid Detail" {
            if let vc = segue.destination as? OrbitalDetailViewController {
                let senderButton = sender as! UIButton
                let buttonPosition = senderButton.convert(CGPoint(), to:asteroidsTableView)
                let indexPath = asteroidsTableView.indexPathForRow(at:buttonPosition) ?? IndexPath()
                
                let asteroid = searchManager.getAsteroidAtIndex(index: indexPath.row)
                let asteroidUid = asteroid?.uid ?? ""
                let asteroidName = asteroid?.name ?? ""
                vc.asteroidUid = asteroidUid
                vc.asteroidDate = convertDateToDateString(date: date)
                vc.asteroidName = asteroidName
            }
        }
    }

    //MARK: - Additional func
    private func convertDateToDateString(date: Date) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
}
