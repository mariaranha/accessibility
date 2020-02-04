//
//  ResultTableViewController.swift
//  Accessibility
//
//  Created by Felipe Luna Tersi on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell : CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardTableViewCell

                return cell
            }
        else if indexPath.row == 1{
            let cell : ResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell

                cell.title.text = "RESULTADO"
                return cell

            }
        else if indexPath.row == 2{
            let cell : RankingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RankingCell", for: indexPath) as! RankingTableViewCell

            cell.countryFlag.image = UIImage(named: "southkorea.png")
            cell.countryName.text = "USA"
            cell.medalIcon.image = UIImage(named: "gold.pdf")
            
            return cell
        }
        
        else if indexPath.row == 3{
            let cell : Ranking2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Ranking2Cell", for: indexPath) as! Ranking2TableViewCell

            cell.countryFlag.image = UIImage(named: "guinea.png")
            cell.countryName.text = "USA"
            cell.medalIcon.image = UIImage(named: "silver.pdf")
            
            return cell
        }
        else {
            let cell : Ranking3TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Ranking3Cell", for: indexPath) as! Ranking3TableViewCell

            cell.countryFlag.image = UIImage(named: "jamaica.png")
            cell.countryName.text = "USA"
            cell.medalIcon.image = UIImage(named: "bronze.pdf")
            
            return cell
        }
        
        }
        
    }


