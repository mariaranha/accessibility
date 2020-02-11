//
//  CollectionViewCell.swift
//  Accessibility
//
//  Created by Marina Miranda Aranha on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    @IBOutlet weak var labelWidth: NSLayoutConstraint!
    @IBOutlet weak var imageLeading: NSLayoutConstraint!
    @IBOutlet weak var imageTrailing: NSLayoutConstraint!
    @IBOutlet weak var imageLeadingGreater: NSLayoutConstraint!
    @IBOutlet weak var imageTrailingGreater: NSLayoutConstraint!
    
    class var reuseIdentifier: String {
        return "CellReuseIdentifier"
    }
    
    func configureCell(sportImage: UIImage, sport: String) {
        
        self.sportImage.image = sportImage
        self.sportNameLabel.text = sport.capitalized
        self.contentView.isAccessibilityElement = true
        let sportAccessibilityLabel = String(format:  NSLocalizedString("Sport: %@",
                                                                       comment: "Sport name"), sport)
        self.contentView.accessibilityLabel = sportAccessibilityLabel
        self.contentView.accessibilityHint = NSLocalizedString("Double tap to access this sport games",
                                                               comment: "Select the sport card")
    }
    
    func addConstraints(){
        let userFontSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        let size = userFontSize.pointSize
        
        //change constraints to allow card to expand
        if size >= 21{
            self.imageLeading.priority = UILayoutPriority(rawValue: 1)
            self.imageTrailing.priority = UILayoutPriority(rawValue: 1)
            self.imageLeadingGreater.priority = UILayoutPriority(rawValue: 1000)
            self.imageTrailingGreater.priority = UILayoutPriority(rawValue: 1000)
            self.labelWidth.constant = 160
        } else {
            self.imageLeading.priority = UILayoutPriority(rawValue: 1000)
            self.imageTrailing.priority = UILayoutPriority(rawValue: 1000)
            self.imageLeadingGreater.priority = UILayoutPriority(rawValue: 1)
            self.imageTrailingGreater.priority = UILayoutPriority(rawValue: 1)
        }
        
        if size >= 40{
            self.sportImage.adjustsImageSizeForAccessibilityContentSizeCategory = true
            self.labelWidth.constant = 250
        } else {
            self.sportImage.adjustsImageSizeForAccessibilityContentSizeCategory = false

        }
        
    }
    
}
