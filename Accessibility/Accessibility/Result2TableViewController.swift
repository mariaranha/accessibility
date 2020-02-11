//
//  Result2TableViewController.swift
//  Accessibility
//
//  Created by Felipe Luna Tersi on 01/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class Result2TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell : Card2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Card2Cell", for: indexPath) as! Card2TableViewCell

                return cell
            }
        else if indexPath.row == 1{
            let cell : ResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Result2Cell", for: indexPath) as! ResultTableViewCell

            cell.title.text = NSLocalizedString("Result", comment: "Game result label")
                return cell

            }
            
        else {
            let cell : RankingTeamTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RankingTeamCell", for: indexPath) as! RankingTeamTableViewCell

            cell.countryFlag1.image = UIImage(named: "southkorea.png")
            cell.countryFlag2.image = UIImage(named: "southkorea.png")
            cell.countryName1.text = "USA"
            cell.countryName2.text = "USA"
            cell.result.text = "3:0"
            cell.gameTitle.text = "Assalto 1"
            
            return cell
        }
    }

}
