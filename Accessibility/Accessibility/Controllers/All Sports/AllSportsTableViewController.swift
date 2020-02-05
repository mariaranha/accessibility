//
//  AllSportsTableViewController.swift
//  Accessibility
//
//  Created by Matheus Oliveira on 03/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class AllSportsTableViewController: UITableViewController {
    
    let jsonManager = JSONManager()
    var json: [Discipline] = []
    var sports: [String]!
    var numberOfSports: Int!
    var selectedSport: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        sports = jsonManager.getSportsOnly()
        numberOfSports = sports.count
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfSports
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! AllSportsTableViewCell
        let sportName: String = sports[indexPath.row]
        
        cell.sportName.text = sportName.capitalized
        cell.sportIcon.image = getIcon(sport: sportName)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedSport = self.sports[indexPath.row]
        performSegue(withIdentifier: "goToDisciplines", sender: nil)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToDisciplines") {
            if let nextViewController = segue.destination as? DisciplinesTableViewController {
                nextViewController.subcategories = jsonManager.getSubcategories(sport: self.selectedSport)
            }
            
        }
    }
    
    // MARK: - Functions
    
    private func getIcon(sport: String) -> UIImage {
        
        let defaultIcon: UIImage = UIImage(named: "soccer-icon")!
        
        if let icon = UIImage(named: "\(sport)-icon") {
            return icon
        }
        
        return defaultIcon
    }

}
