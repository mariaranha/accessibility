//
//  CardDetailPresenter.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 07/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import Foundation
import UIKit

class CardDetailPresenter {
    
    func formatCards(title: String,
                     subtitle: String,
                     numberOfPoints: String,
                     firstCountryName: String,
                     secondCountryName: String,
                     day: String,
                     month: String,
                     time: String,
                     cornerImage: UIImage,
                     firstCountryFlag: UIImage,
                     secondCountryFlag: UIImage) -> CardView.ViewModel {
        
        let card = CardView.ViewModel(title: title.capitalized,
                                      subtitle: subtitle.capitalized,
                                      numberOfPoints: numberOfPoints,
                                      firstCountryName: firstCountryName,
                                      secondCountryName: secondCountryName,
                                      day: day,
                                      mounth: month,
                                      time: time,
                                      cornerImage: cornerImage,
                                      firstCountryFlag: firstCountryFlag,
                                      secondCountryFlag: secondCountryFlag)
        
        return card
    }
    
    func formatCardsDynamic(title: String,
                            subtitle: String,
                            numberOfPoints: String,
                            firstCountryName: String,
                            secondCountryName: String,
                            date: String,
                            firstCountryFlag: UIImage,
                            secondCountryFlag: UIImage) -> CardViewDynamic.ViewModel {
        
        let cardDynamic = CardViewDynamic.ViewModel(title: title.capitalized,
                                                    subtitle: subtitle.capitalized,
                                                    numberOfPoints: numberOfPoints,
                                                    firstCountryName: firstCountryName,
                                                    secondCountryName: secondCountryName,
                                                    date: date,
                                                    firstCountryFlag: firstCountryFlag,
                                                    secondCountryFlag: secondCountryFlag)
                
        
        return cardDynamic
    }
}
