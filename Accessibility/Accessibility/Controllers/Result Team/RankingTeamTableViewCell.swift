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
        flag1View.accessibilityLabel = NSLocalizedString ("Bandeira do país \(countryName1.text ?? "País")", comment: "Accessibility Label: Bandeira do páis")
        
        countryName1.isAccessibilityElement = true
        countryName1.accessibilityLabel = NSLocalizedString ("Nome do país \(countryName1.text ?? "País")", comment: "Accessibility Label: Nome do país")
        
        flag2View.isAccessibilityElement = true
        flag2View.accessibilityLabel = NSLocalizedString ("Bandeira do país \(countryName2.text ?? "País")", comment: "Accessibility Label: Bandeira do páis")
        
        countryName2.isAccessibilityElement = true
        countryName2.accessibilityLabel = NSLocalizedString ("Nome do país \(countryName2.text ?? "País")", comment: "Accessibility Label: Nome do país")
        
        gameTitle.isAccessibilityElement = true
        gameTitle.accessibilityLabel = NSLocalizedString ("Tipo de partida \(gameTitle.text ?? "País")", comment: "Accessibility Label: Tipo de partida")
        
        result.isAccessibilityElement = true
        result.accessibilityLabel = NSLocalizedString ("Resultado do jogo \(result.text ?? "País")", comment: "Accessibility Label: Placar resultado da modalidade")
    }

}
