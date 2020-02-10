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
 
    func formatCards(title: String, subtitle: String, numberOfPoints: String,
                     firstCountryName: String, secondCountryName: String, day: String,
                     mounth: String, time: String, index: Int, viewModelArray: [CardView.ViewModel]) -> [CardView.ViewModel] {
        
        let emptyFlag = UIImage(named: "empty-flag") ?? UIImage()
        
        var newViewModelArray: [CardView.ViewModel] = viewModelArray
        
        setCornerImage()
        
        let newCard = CardView.ViewModel(title: title.capitalized,
                                         subtitle: subtitle.capitalized,
                                         numberOfPoints: numberOfPoints,
                                         firstCountryName: firstCountryName,
                                         secondCountryName: secondCountryName,
                                         day: day,
                                         mounth: mounth,
                                         time: time,
                                         cornerImage: cornerImages[0], //use i inside for model in models
                                         firstCountryFlag: UIImage(named: "brazil-flag-xl") ?? emptyFlag,
                                         secondCountryFlag: UIImage(named: "china-flag-xl") ?? emptyFlag)
        
        newViewModelArray.append(newCard)
        
        return newViewModelArray
    }
    
    func formatCardsDynamic(title: String,
                            subtitle: String,
                            numberOfPoints: String,
                            firstCountryName: String,
                            secondCountryName: String,
                            date: String,
                            viewModelArray: [CardViewDynamic.ViewModel]) -> [CardViewDynamic.ViewModel]  {
        
        let emptyFlag = UIImage(named: "empty-flag") ?? UIImage()
        
        var newViewModelArray: [CardViewDynamic.ViewModel] = viewModelArray
        
        let newCard = CardViewDynamic.ViewModel(title: title.capitalized,
                                                subtitle: subtitle.capitalized,
                                                numberOfPoints: numberOfPoints,
                                                firstCountryName: firstCountryName,
                                                secondCountryName: secondCountryName,
                                                date: "24 JUN 12:40",
                                                firstCountryFlag: UIImage(named: "brazil-flag-xl") ?? emptyFlag,
                                                secondCountryFlag: UIImage(named: "china-flag-xl") ?? emptyFlag)
        
        newViewModelArray.append(newCard)
        
        return newViewModelArray
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
        
        


