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
    
    var searchManager: SearchManager = SearchManager()
    
    var date = Date()
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchManager.delegate = self
        dataService.searchManager = searchManager
        
        asteroidsTableView.dataSource = dataService
        asteroidsTableView.delegate = dataService
        
        asteroidsTableView.estimatedRowHeight = 44.0
        asteroidsTableView.rowHeight = UITableViewAutomaticDimension
        
        searchManager.getAsteroidsForDate(date: date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        asteroidsTableView.reloadData()
    }
    
    //MARK: - Handle request results
    func handleResult() {
        asteroidsTableView.reloadData()
    }
    
    func handleErrorWithMessage(errorMessage: String) {
        showAlertWithTitle("\(NSLocalizedString("Attention", comment: ""))", andMessage: errorMessage)
    }
    
    //MARK: - Actions
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
