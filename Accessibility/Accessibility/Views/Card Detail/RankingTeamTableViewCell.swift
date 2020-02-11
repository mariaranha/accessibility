//
//  RankingTeamTableViewCell.swift
//  Accessibility
//
//  Created by Felipe Luna Tersi on 01/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class RankingTeamTableViewCell: UITableViewCell {

    @IBOutlet weak var countryFlag1: UIImageView!
    @IBOutlet weak var countryFlag2: UIImageView!
    @IBOutlet weak var countryName1: UILabel!
    @IBOutlet weak var countryName2: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var flag1View: UIView!
    @IBOutlet weak var flag2View: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        flag1View.isAccessibilityElement = true
        flag1View.accessibilityLabel = String(format: NSLocalizedString ("Country flag %@", comment: "Accessibility Label: Country flag"), countryName1.text ?? "país")
        
        countryName1.isAccessibilityElement = true
        countryName1.accessibilityLabel = String(format: NSLocalizedString ("Country name: %@", comment: "Accessibility Label: Country name"), countryName1.text ?? "País")
        
        flag2View.isAccessibilityElement = true
        flag2View.accessibilityLabel = String(format: NSLocalizedString ("Country flag %@", comment: "Accessibility Label: Country flag"), countryName2.text ?? "país")
        
        countryName2.isAccessibilityElement = true
        countryName2.accessibilityLabel = String(format: NSLocalizedString ("Country name: %@", comment: "Accessibility Label: Country name"), countryName2.text ?? "País")
        
        gameTitle.isAccessibilityElement = true
        gameTitle.accessibilityLabel = String(format: NSLocalizedString("Sport %@", comment: "Accessibility Label: Tipo de partida"), gameTitle.text ?? "Title")
        
        result.isAccessibilityElement = true
        result.accessibilityLabel = String(format: NSLocalizedString("Result %@", comment: "Accessibility Label: Sport match result"), result.text ?? "")
    }

}
