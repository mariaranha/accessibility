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
    var sportsDisplayName: [String]!
    var sportsArray: [Discipline]!
    var numberOfSports: Int!
    var selectedSportDisplayName: String!
    var selectedSport: Discipline!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sportsDisplayName = jsonManager.getSportsForDisplay()
        self.numberOfSports = sportsDisplayName.count
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
        let sportName: String = sportsDisplayName[indexPath.row]
        cell.sportName.text = sportName.capitalized
        cell.sportIcon.image = getIcon(sport: sportName)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedSportDisplayName = self.sportsDisplayName[indexPath.row]
        self.sportsArray = jsonManager.getSportNamed(sport: self.selectedSportDisplayName)
        if (sportsArray.count == 2) {
            self.selectedSport = sportsArray[0]
            performSegue(withIdentifier: "sportsToCards", sender: nil)
        } else {
            performSegue(withIdentifier: "goToDisciplines", sender: nil)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToDisciplines") {
            if let nextViewController = segue.destination as? DisciplinesTableViewController {
                nextViewController.subcategories = jsonManager.getSubcategories(sport: self.selectedSportDisplayName)
            }
        } else if (segue.identifier == "sportsToCards") {
            if let newVC = segue.destination as? SportMatchesViewController {
                newVC.discipline = self.selectedSport
                newVC.matchDay = 23
                newVC.dayOnly = false
                newVC.sportTitle = self.selectedSportDisplayName
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
