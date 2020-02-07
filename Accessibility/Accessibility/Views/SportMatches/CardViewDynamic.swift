//
//  CardViewDynamic.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 05/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import Foundation
import UIKit

final class CardViewDynamic: UIView {
    
    @IBOutlet var contentView: UIView!
    
    //Card Labels
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var pointsLabel: UILabel?
    @IBOutlet weak var numberOfPointsLabel: UILabel?
    @IBOutlet weak var firstCountryLabel: UILabel?
    @IBOutlet weak var secondCountryLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    
    //Card images
    @IBOutlet weak var firstCountryImage: UIImageView?
    @IBOutlet weak var secondCountryImage: UIImageView?
    
    //Buttons
    @IBOutlet weak var firstCountryButton: UIButton!
    @IBOutlet weak var secondCountryButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        Bundle.main.loadNibNamed("CardViewDynamic", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configure(with viewModel: ViewModel) {
        titleLabel?.text = viewModel.title
        subtitleLabel?.text = viewModel.subtitle
        subtitleLabel?.sizeToFit()
        numberOfPointsLabel?.text = viewModel.numberOfPoints
        firstCountryLabel?.text = viewModel.firstCountryName
        secondCountryLabel?.text = viewModel.secondCountryName
        dateLabel?.text = viewModel.date
        
        firstCountryImage?.image = viewModel.firstCountryFlag
        secondCountryImage?.image = viewModel.secondCountryFlag
        
        layoutIfNeeded()
    }
}


extension CardViewDynamic {
    struct ViewModel {
        let title: String
        let subtitle: String
        let numberOfPoints: String
        let firstCountryName: String
        let secondCountryName: String
        let date: String
        let firstCountryFlag: UIImage
        let secondCountryFlag: UIImage
    }
}
