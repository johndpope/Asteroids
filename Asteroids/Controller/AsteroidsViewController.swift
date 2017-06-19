//
//  AsteroidsViewController.swift
//  Asteroids
//
//  Created by olegshamin on 19/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import UIKit

class AsteroidsViewController: UIViewController {

    @IBOutlet weak var asteroidsListTableView: UITableView!
    @IBOutlet var dataService: AsteroidsListDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.asteroidsListTableView.dataSource = dataService
        self.asteroidsListTableView.delegate = dataService
    }
    

}
