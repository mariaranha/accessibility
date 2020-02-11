//
//  CardTableViewCell.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit
import Foundation

class CardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: CardView?
    @IBOutlet weak var cardViewDynamic: CardViewDynamic!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if cardView?.contentView != nil {
            cardView?.contentView.layer.cornerRadius = 8
        }
        
        if cardViewDynamic?.contentView != nil {
            cardViewDynamic?.contentView.layer.cornerRadius = 8
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if cardView?.contentView != nil {
            setCardViewVoiceOver()
        }
        
        if cardViewDynamic?.contentView != nil {
            setCardViewDynamicVoiceOver()
        }
    }

    func configure(with viewModel: CardView.ViewModel) {
        cardView?.configure(with: viewModel)
    }
    
    func configureDynamic(with viewModel: CardViewDynamic.ViewModel) {
        cardViewDynamic?.configure(with: viewModel)
    }
}

// MARK: Voice Over
extension CardTableViewCell {
    func setCardViewVoiceOver() {
        let title = cardView?.titleLabel?.text
        let subtitle = cardView?.subtitleLabel?.text
        let points = cardView?.numberOfPointsLabel?.text
        let day = cardView?.dayLabel?.text
        let month = cardView?.monthLabel?.text
        let time = cardView?.timeLabel?.text
        let firstCountry = cardView?.firstCountryLabel?.text
        let secondCountry = cardView?.secondCountryLabel?.text
        let firstButton = cardView?.firstCountryButton
        let secondButton = cardView?.secondCountryButton
        
        cardView?.isAccessibilityElement = true
        firstButton?.isAccessibilityElement = true
        secondButton?.isAccessibilityElement = true
        
        var cardAccessInfo = ""
        
        if points != "" && points != "–" && points != nil {
            
            cardAccessInfo = String(format: NSLocalizedString("Match ended %@, %@, %@ %@ at %@. Brazil versus China. You did %@ points", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países, pontuação"), title ?? "", subtitle ?? "", day ?? "", month ?? "", time ?? "", points ?? "")
            
            firstButton?.isAccessibilityElement = false
            secondButton?.isAccessibilityElement = false
        } else {
            if firstCountry != "???" || secondCountry != "???" {
                
                cardAccessInfo = String(format: NSLocalizedString("Match %@. %@. %@ %@ at %@. Brazil versus China. Select a country to throb or double tap for more information", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países"), title ?? "", subtitle ?? "", day ?? "", month ?? "", time ?? "")

                firstButton?.accessibilityHint = String(format: NSLocalizedString("Double tap to throb at Brazil", comment: ""))
                secondButton?.accessibilityHint = String(format: NSLocalizedString("Double tap to throb at China", comment: ""))
                
            } else {
                
                cardAccessInfo = String(format: NSLocalizedString("Partida %@, %@, dia %@ de %@ às %@. Países não definidos", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países"), title ?? "", subtitle ?? "", day ?? "", month ?? "", time ?? "")
                
            }
        }
    
        cardView?.accessibilityLabel = cardAccessInfo
        
        accessibilityElements = [cardView as Any, firstButton as Any, secondButton as Any]
    }
    
    func setCardViewDynamicVoiceOver() {
        let title = cardViewDynamic?.titleLabel?.text
        let subtitle = cardViewDynamic?.subtitleLabel?.text
        let points = cardViewDynamic?.numberOfPointsLabel?.text
        let date = cardViewDynamic.dateLabel?.text
        let firstCountry = cardViewDynamic?.firstCountryLabel?.text
        let secondCountry = cardViewDynamic?.secondCountryLabel?.text
        let firstButton = cardViewDynamic?.firstCountryButton
        let secondButton = cardViewDynamic?.secondCountryButton
        
        cardViewDynamic?.isAccessibilityElement = true
        firstButton?.isAccessibilityElement = true
        secondButton?.isAccessibilityElement = true
        
        var cardAccessInfo = ""
        
        if points != "" && points != "–" && points != nil {
            
            cardAccessInfo = String(format: NSLocalizedString("Match ended. %@. %@. %@. %@ versus %@.", comment: ""), title ?? "", subtitle ?? "", date ?? "", firstCountry ?? "", secondCountry ?? "")
        } else {
            if firstCountry != "???" {
                cardAccessInfo = String(format: NSLocalizedString("Match %@. %@. %@ %@ at %@. Brazil versus China. Select a country to throb or double tap for more information", comment: "Match card with informations: Title, subtitle, date and countries"), title ?? "", subtitle ?? "", date ?? "")
                
                firstButton?.accessibilityHint = NSLocalizedString("Clique duas vezes para palpitar em Brazil", comment: "")
                secondButton?.accessibilityHint = NSLocalizedString("Clique duas vezes para palpitar em China)", comment: "")
            } else {
                cardAccessInfo = String(format: NSLocalizedString("Match. %@. %@. %@. Undefinied countries", comment: ""),title ?? "", subtitle ?? "", date ?? "" )
            }
        }
    
        cardViewDynamic?.accessibilityLabel = cardAccessInfo
        
        accessibilityElements = [cardViewDynamic as Any, firstButton as Any, secondButton as Any]
    }
}
