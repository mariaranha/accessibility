//
//  SubcategoriesTableViewCell.swift
//  Accessibility
//
//  Created by Matheus Oliveira on 03/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class SubcategoriesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var subcategoryName: UILabel!
    @IBOutlet weak var subcategoryView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
