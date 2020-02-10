//
//  CalendarCollectionViewCell.swift
//  Accessibility
//
//  Created by Marina Miranda Aranha on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayStack: UIStackView!
        
    class var reuseIdentifier: String {
        return "CalendarCellReuseIdentifier"
    }
    
    func configureCell(weekDay: String, day: String) {
        
        self.dayLabel.isAccessibilityElement = true
        self.dayLabel.accessibilityLabel = NSLocalizedString ("Dia \(day) \(getWeekdayName(weekday: day))", comment: "Dia da semana")
        self.dayLabel.accessibilityHint = NSLocalizedString ("Clique duas vezes para selecionar", comment: "Selecionar dia da semana")

        self.weekDayLabel.text = weekDay
        self.dayLabel.text = day
        
    }
    
    func getWeekdayName(weekday: String) -> String {
        
        switch weekday {
        case "22":
            return "segunda feira"
        case "23":
            return "terca feira"
        case "24":
            return "quarta feira"
        case "25":
            return "quinta feira"
        case "26":
            return "sexta feira"
        case "27":
            return "sabado"
        case "28":
            return "domingo"
        case "29":
            return "segunda feira"
        case "30":
            return "terca feira"
        case "31":
            return "quarta feira"
        case "01":
            return "quinta feira"
        case "02":
            return "sexta feira"
        case "03":
            return "sabado"
        case "04":
            return "domingo"
        case "05":
            return "segunda feira"
        case "06":
            return "terca feira"
        case "07":
            return "quarta feira"
        case "08":
            return "quinta feira"
        case "09":
            return "sexta feira"
        default: return "01"
        }
        
    }
    
    func selectDay(isSelected: Bool){
        if isSelected{
            self.selectedImage.isHidden = false
        } else {
            self.selectedImage.isHidden = true
        }
    }
    


}
