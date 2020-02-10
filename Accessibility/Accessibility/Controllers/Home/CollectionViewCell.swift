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
    
}
