//
//  SportMatchesPresenter.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 03/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

//CARD MODEL
//struct CardModel {
//    let firstTitle: String?
//    let secondTitle: String?
//}

class SportMatchesPresenter {
    
    var cornerImages: [UIImage] = []
    var numberOfCard = 2 //get from model
    
    //Corner colors
    var cornerColors = [UserCornerImage.blue,
                        UserCornerImage.yellow,
                        UserCornerImage.black,
                        UserCornerImage.green,
                        UserCornerImage.red]
 
    func formatCards() -> [CardView.ViewModel] {
        let emptyFlag = UIImage(named: "empty-flag") ?? UIImage()
        
        setCornerImage()
        
        let array = [CardView.ViewModel(title: "Feminino",
                                       subtitle: "Peso Mosca (48-51kg) - Eliminatórias",
                                       numberOfPoints: "–",
                                       firstCountryName: "BRA",
                                       secondCountryName: "CHN",
                                       day: "24",
                                       mounth: "JUN",
                                       time: "12:40",
                                       cornerImage: cornerImages[0], //use i inside for model in models
                                       firstCountryFlag: UIImage(named: "brazil-flag-xl") ?? emptyFlag,
                                       secondCountryFlag: UIImage(named: "china-flag-xl") ?? emptyFlag),
                     CardView.ViewModel(title: "Masculino",
                                       subtitle: "Peso Galo (56kg) - Quartas de final",
                                       numberOfPoints: "20",
                                       firstCountryName: "USA",
                                       secondCountryName: "PAK",
                                       day: "25",
                                       mounth: "JUN",
                                       time: "12:30PM",
                                       cornerImage: cornerImages[1],
                                       firstCountryFlag: UIImage(named: "united-states-of-america-flag-xl") ?? emptyFlag,
                                       secondCountryFlag: UIImage(named: "pakistan-flag-xl") ?? emptyFlag),
                    ]
        
        return array
    }
    
    func formatCardsDynamic() -> [CardViewDynamic.ViewModel] {
        let emptyFlag = UIImage(named: "empty-flag") ?? UIImage()
        
        let array = [CardViewDynamic.ViewModel(title: "Feminino",
                                       subtitle: "Peso Mosca (48-51kg) - Eliminatórias",
                                       numberOfPoints: "–",
                                       firstCountryName: "BRA",
                                       secondCountryName: "CHN",
                                       date: "24 JUN 12:40",
                                       firstCountryFlag: UIImage(named: "brazil-flag-xl") ?? emptyFlag,
                                       secondCountryFlag: UIImage(named: "china-flag-xl") ?? emptyFlag),
                     CardViewDynamic.ViewModel(title: "Masculino",
                                       subtitle: "Peso Galo (56kg) - Quartas de final",
                                       numberOfPoints: "20",
                                       firstCountryName: "USA",
                                       secondCountryName: "PAK",
                                       date: "25 JUN 12:30PM",
                                       firstCountryFlag: UIImage(named: "united-states-of-america-flag-xl") ?? emptyFlag,
                                       secondCountryFlag: UIImage(named: "pakistan-flag-xl") ?? emptyFlag),
                    ]
        
        return array
    }
    
    func setCornerImage() {
        //User default for color
        let cornerDefaultColor = UserDefaultsStruct.CornerMode.color
        if cornerDefaultColor == .colorful {
            cornerImages = []
            colorfulCorner()
        } else {
            cornerImages = []
            for _ in 0...(numberOfCard - 1) {
                var cornerImg = UIImage()
                cornerImageName(cornerDefaultColor, &cornerImg)
                cornerImages.append(cornerImg)
            }
        }
    }
    
    func colorfulCorner() {
        //Card Corner Image - For colorfull mode
        var randomNumber = Int.random(in: 0...4)
        
        for _ in 0...(numberOfCard - 1) {
            
            if randomNumber < 4 {
                randomNumber += 1
            } else {
                randomNumber = 0
            }
            
            let corner = cornerColors[randomNumber]
            var cornerImg = UIImage()
            
            //Set the image for each case
            cornerImageName(corner, &cornerImg)
            
            cornerImages.append(cornerImg)
        }
    }
    
    func cornerImageName(_ corner: UserCornerImage, _ cornerImg: inout UIImage) {
        switch corner {
        case .blue:
            cornerImg = UIImage(named: "corner-blue") ?? UIImage()
        case .yellow:
            cornerImg = UIImage(named: "corner-yellow") ?? UIImage()
        case .black:
            cornerImg = UIImage(named: "corner-black") ?? UIImage()
        case .green:
            cornerImg = UIImage(named: "corner-green") ?? UIImage()
        case .red:
            cornerImg = UIImage(named: "corner-red") ?? UIImage()
        case .colorful:
            break
        }
    }

}


//    func formatCards(_ models: [CardModel]) -> [CardView.ViewModel] {
//        var viewModels: [Card.ViewModel] = []
//
//        for model in models {
//            viewModels.append(.init(title: model.firstTitle ?? model.secondTitle ?? "",
//                                    subtitle: T##String,
//                                    numberOfPoints: <#T##String#>,
//                                    firstCountryName: <#T##String#>,
//                                    secondCountryName: <#T##String#>,
//                                    day: <#T##String#>, mounth: <#T##String#>,
//                                    time: <#T##String#>,
//                                    cornerImage: <#T##UIImage#>,
//                                    firstCountryFlag: <#T##UIImage#>,
//                                    secondCountryFlag: <#T##UIImage#>)
//        }
        
        


