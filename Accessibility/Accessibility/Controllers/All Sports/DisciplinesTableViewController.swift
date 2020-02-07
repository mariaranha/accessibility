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
    var subcategories: [Discipline] = []
    var subcategoriesNumber: Int!
    var selectedDiscipline: String!

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
        cell.subcategoryName.text = subcategories[indexPath.row].name.capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        if let currentCell = tableView.cellForRow(at: indexPath!) as? SubcategoriesTableViewCell {
            self.selectedDiscipline = currentCell.subcategoryName.text ?? ""
        }
        performSegue(withIdentifier: "subcategoriesToCards", sender: nil)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "subcategoriesToCards") {
            if let newVC = segue.destination as? SportMatchesViewController {
                newVC.discipline = getEspecificCategory(subcategories: self.subcategories)
                newVC.matchDay = 23
                newVC.dayOnly = false
                newVC.sportTitle = self.selectedDiscipline
            }
        }
    }
    
    private func getEspecificCategory(subcategories: [Discipline]) -> Discipline? {
        for element in subcategories {
            if (element.name.capitalized == selectedDiscipline) {
                return element
            }
        }
        return nil
    }
}
