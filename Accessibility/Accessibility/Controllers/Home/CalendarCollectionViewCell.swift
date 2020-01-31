//
//  CalendarCollectionViewCell.swift
//  Accessibility
//
//  Created by Marina Miranda Aranha on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    class var reuseIdentifier: String {
        return "CalendarCellReuseIdentifier"
    }
    
    func configureCell(weekDay: String, day: String) {
        self.weekDayLabel.text = weekDay
        self.dayLabel.text = day
    }


}
