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
    }
    
}
