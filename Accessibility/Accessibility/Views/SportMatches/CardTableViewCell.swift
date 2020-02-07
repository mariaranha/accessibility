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
        
        var cardAccesInfo = ""
        
        if points != "" && points != "–" && points != nil {
            cardAccesInfo = NSLocalizedString("Partida encerrada \(title ?? ""), \(subtitle ?? ""), dia \(day ?? "") de \(month ?? "") às \(time ?? ""). \(firstCountry ?? "") versus \(secondCountry ?? ""). Você fez \(points ?? "") pontos", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países, pontuação")
        } else {
            if firstCountry != "???" {
                cardAccesInfo = NSLocalizedString("Partida \(title ?? ""), \(subtitle ?? ""), dia \(day ?? "") de \(month ?? "") às \(time ?? ""). \(firstCountry ?? "") versus \(secondCountry ?? ""). Selecione um país para palpitar", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países")
                
                firstButton?.accessibilityHint = NSLocalizedString("Clique duas vezes para palpitar em \(firstCountry ?? "País")", comment: "")
                secondButton?.accessibilityHint = NSLocalizedString("Clique duas vezes para palpitar em \(secondCountry ?? "País")", comment: "")
            } else {
                cardAccesInfo = NSLocalizedString("Partida \(title ?? ""), \(subtitle ?? ""), dia \(day ?? "") de \(month ?? "") às \(time ?? ""). Países não definidos", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países")
            }
        }
    
        cardView?.accessibilityLabel = cardAccesInfo
        
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
        
        var cardAccesInfo = ""
        
        if points != "" && points != "–" && points != nil {
            cardAccesInfo = NSLocalizedString("Partida encerrada \(title ?? ""), \(subtitle ?? ""), dia \(date ?? ""). \(firstCountry ?? "") versus \(secondCountry ?? ""). Você fez \(points ?? "") pontos", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países, pontuação")
        } else {
            if firstCountry != "???" {
                cardAccesInfo = NSLocalizedString("Partida \(title ?? ""), \(subtitle ?? ""), dia \(date ?? ""). \(firstCountry ?? "") versus \(secondCountry ?? ""). Selecione um país para palpitar", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países")
                
                firstButton?.accessibilityHint = NSLocalizedString("Clique duas vezes para palpitar em \(firstCountry ?? "País")", comment: "")
                secondButton?.accessibilityHint = NSLocalizedString("Clique duas vezes para palpitar em \(secondCountry ?? "País")", comment: "")
            } else {
                cardAccesInfo = NSLocalizedString("Partida \(title ?? ""), \(subtitle ?? ""), dia \(date ?? ""). Países não definidos", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países")
            }
        }
    
        cardViewDynamic?.accessibilityLabel = cardAccesInfo
        
        accessibilityElements = [cardViewDynamic as Any, firstButton as Any, secondButton as Any]
    }


    func configure(with viewModel: CardView.ViewModel) {
        cardView?.configure(with: viewModel)
    }
    
    func configureDynamic(with viewModel: CardViewDynamic.ViewModel) {
        cardViewDynamic?.configure(with: viewModel)
    }
}
