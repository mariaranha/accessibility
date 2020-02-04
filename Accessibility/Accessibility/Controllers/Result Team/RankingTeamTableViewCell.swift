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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        flag1View.isAccessibilityElement = true
        flag1View.accessibilityHint = "bandeira do \(countryName1.text ?? "País")"
        
        countryName1.isAccessibilityElement = true
        countryName1.accessibilityHint = "nome do país"
        
        flag2View.isAccessibilityElement = true
        flag2View.accessibilityHint = "bandeira do país"
        
        countryName2.isAccessibilityElement = true
        countryName2.accessibilityHint = "nome do país"
        
        gameTitle.isAccessibilityElement = true
        gameTitle.accessibilityHint = "tipo de partida"
        
        result.isAccessibilityElement = true
        result.accessibilityHint = "resultado do jogo"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
