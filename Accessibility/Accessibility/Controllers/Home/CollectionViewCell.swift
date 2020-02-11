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
    }
    
    func addConstraints(){
        let userFontSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        let size = userFontSize.pointSize
        
        if size >= 21{
            self.imageLeading.priority = UILayoutPriority(rawValue: 1)
            self.imageTrailing.priority = UILayoutPriority(rawValue: 1)
            self.imageLeadingGreater.priority = UILayoutPriority(rawValue: 1000)
            self.imageTrailingGreater.priority = UILayoutPriority(rawValue: 1000)
        } else {
            self.imageLeading.priority = UILayoutPriority(rawValue: 1000)
            self.imageTrailing.priority = UILayoutPriority(rawValue: 1000)
            self.imageLeadingGreater.priority = UILayoutPriority(rawValue: 1)
            self.imageTrailingGreater.priority = UILayoutPriority(rawValue: 1)
        }
    }
    
}
