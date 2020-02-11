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
        let mounth = returnMounth(day: day)
        let weekdayName = getWeekdayName(weekday: day)
        let accessibilityDayLabel = String(format: NSLocalizedString("%@ %@ %@",
                                                                     comment: "Date of the day"), weekdayName, mounth, day)
        self.dayLabel.accessibilityLabel = accessibilityDayLabel
        self.dayLabel.accessibilityHint = NSLocalizedString ("Double tap to select", comment: "Select week day")

        self.weekDayLabel.text = weekDay
        self.dayLabel.text = day
        
    }
    
    private func returnMounth(day: String) -> String {
        let august: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let augustName = NSLocalizedString("August", comment: "Abreviation of august month")
        let julyName = NSLocalizedString("July", comment: "Abreviation of july month")
        if (august.contains(day)) {
            return augustName
        } else {
            return julyName
        }
    }
    
    func getWeekdayName(weekday: String) -> String {
        
        let sunday = NSLocalizedString("Sunday", comment: "Week day")
        let monday = NSLocalizedString("Monday", comment: "Week day")
        let tuesday = NSLocalizedString("Tuesday", comment: "Week day")
        let wednesday = NSLocalizedString("Wednesday", comment: "Week day")
        let thursday = NSLocalizedString("Thursday", comment: "Week day")
        let friday = NSLocalizedString("friday", comment: "Week day")
        let saturday = NSLocalizedString("Saturday", comment: "Week day")
        
        switch weekday {
        case "22", "29", "05":
            return monday
        case "23", "30", "06":
            return tuesday
        case "24", "31", "07":
            return wednesday
        case "25", "01", "08":
            return thursday
        case "26", "02", "09":
            return friday
        case "27", "03":
            return saturday
        case "28", "04":
            return sunday
        default: return "Invalid"
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
