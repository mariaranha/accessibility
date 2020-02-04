//
//  CardTableViewCell.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit
import Foundation

class CardTableViewCell: UITableViewCell {
    
    //Card Labels
    @IBOutlet weak var cardView: CardView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView?.contentView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with viewModel: CardView.ViewModel) {
        cardView?.configure(with: viewModel)
    }
}
