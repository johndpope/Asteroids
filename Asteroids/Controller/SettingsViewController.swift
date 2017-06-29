//
//  SettingsViewController.swift
//  Asteroids
//
//  Created by bu on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let settings = ["km","mi"]
    
    //MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - TableView datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell")!
        
        cell.textLabel?.text = settings[indexPath.row];
        if (Constants.system == System.metric.rawValue && indexPath.row == 0) ||
            (Constants.system == System.imperial.rawValue && indexPath.row == 1) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    //MARK: - TableView delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            Constants.system = System.metric.rawValue
        } else {
            Constants.system = System.imperial.rawValue
        }
        tableView.reloadData()
    }
}
