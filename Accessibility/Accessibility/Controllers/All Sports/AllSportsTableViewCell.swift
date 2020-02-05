//
//  AllSportsTableViewCell.swift
//  Accessibility
//
//  Created by Matheus Oliveira on 03/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class AllSportsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var sportIcon: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.cellView.isAccessibilityElement = true
        self.cellView.accessibilityLabel = "\(sportName.text ?? "Sport") icon. \(sportName.text ?? "Sport"). Button."
    }

}
