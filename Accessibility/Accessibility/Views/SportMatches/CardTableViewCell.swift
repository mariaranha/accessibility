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
            
            cardAccessInfo = String(format: NSLocalizedString("Match ended %@, %@, %@ %@ at %@. %@ versus %@. You did %@ points", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países, pontuação"), title ?? "", subtitle ?? "", day ?? "", month ?? "", time ?? "", firstCountry ?? "", secondCountry ?? "", points ?? "")
            
            firstButton?.isAccessibilityElement = false
            secondButton?.isAccessibilityElement = false
        } else {
            if firstCountry != "???" || secondCountry != "???" {
                
                cardAccessInfo = String(format: NSLocalizedString("Match %@. %@. %@ %@ at %@. %@ versus %@. Select a country to throb", comment: "Card da partida com todas as informações: Título, subtítulo, dia, mês, hora, países"), title ?? "", subtitle ?? "", day ?? "", month ?? "", time ?? "", firstCountry ?? "País indefinido", secondCountry ?? "País indefinido")
                
                if firstButton?.isSelected ?? true {
                    
                    firstButton?.accessibilityHint = String(format: NSLocalizedString("You throbbed at %@", comment: ""), firstCountry ?? "País indefinido")
                } else {
                    firstButton?.accessibilityHint = String(format: NSLocalizedString("Double tap to throb at %@", comment: ""), firstCountry ?? "País indefinido")
                    
                }
                
                secondButton?.accessibilityHint = String(format: NSLocalizedString("Double tap to throb at %@", comment: ""), secondCountry ?? "País indefinido")
                
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
}


//Not working
//class AccessibilityButton: UIButton {
//
//    override func accessibilityActivate() -> Bool {
//        let cardView = CardView()
//        let firstCoutry = cardView.firstCountryLabel?.text ?? "País indefinido"
//        let isFirstCountrySelected = cardView.isFirstCountrySelected
//        
//        if isFirstCountrySelected {
//            accessibilityLabel = "Você palpitou em \(firstCoutry)"
//            accessibilityHint = "Selecione duas vezes para remover o palpite"
//        } else {
//            accessibilityLabel = "Você removeu seu palpite em \(firstCoutry)"
//            accessibilityHint = "Selecione duas vezes para palpitar"
//        }
//        
//        
//        return false
//    }
//}
