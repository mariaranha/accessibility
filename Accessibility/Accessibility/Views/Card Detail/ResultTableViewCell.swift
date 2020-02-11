//
//  Result2TableViewCell.swift
//  Accessibility
//
//  Created by Felipe Luna Tersi on 01/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.isAccessibilityElement = true
        title.accessibilityHint = "título"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
