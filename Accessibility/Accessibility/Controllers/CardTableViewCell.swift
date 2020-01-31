//
//  CardTableViewCell.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    //Card Labels
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var numberOfPointsLabel: UILabel!
    @IBOutlet weak var firstCountryLabel: UILabel!
    @IBOutlet weak var secondCountryLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //Card Images
    @IBOutlet weak var ringImage: UIImageView!
    @IBOutlet weak var cornerImage: UIImageView!
    @IBOutlet weak var firstCountryImage: UIImageView!
    @IBOutlet weak var secondCountryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
