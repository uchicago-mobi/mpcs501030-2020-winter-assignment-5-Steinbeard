//
//  FavoritesViewController.swift
//  WhereIntheWorld
//
//  Created by Daniel Steinberg on 2/11/20.
//  Copyright © 2020 Daniel Steinberg. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Constraints weird
    }
    
}
