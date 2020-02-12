//
//  FavoritesViewController.swift
//  WhereIntheWorld
//
//  Created by Daniel Steinberg on 2/11/20.
//  Copyright © 2020 Daniel Steinberg. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var favorites = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favorites = DataManager.sharedInstance.listFavorites()
        print(favorites)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = favorites[indexPath.row]
        return cell
    }
}

