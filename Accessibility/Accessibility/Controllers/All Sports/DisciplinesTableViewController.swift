//
//  DisciplinesTableViewController.swift
//  Accessibility
//
//  Created by Matheus Oliveira on 03/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class DisciplinesTableViewController: UITableViewController {
    
    var jsonManager = JSONManager()
    var subcategories: [String] = []
    var subcategoriesNumber: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        subcategoriesNumber = subcategories.count
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategoriesNumber
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subcategoryCell", for: indexPath) as! SubcategoriesTableViewCell
        cell.subcategoryName.text = subcategories[indexPath.row].capitalized
        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
