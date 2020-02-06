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
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var pointsLabel: UILabel?
    @IBOutlet private weak var numberOfPointsLabel: UILabel?
    @IBOutlet private weak var firstCountryLabel: UILabel?
    @IBOutlet private weak var secondCountryLabel: UILabel?
    @IBOutlet private weak var dateLabel: UILabel?
    
    //Card images
    @IBOutlet private weak var firstCountryImage: UIImageView?
    @IBOutlet private weak var secondCountryImage: UIImageView?
    
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
        numberOfPointsLabel?.text = viewModel.numberOfPoints
        firstCountryLabel?.text = viewModel.firstCountryName
        secondCountryLabel?.text = viewModel.secondCountryName
        dateLabel?.text = viewModel.date
        
        firstCountryImage?.image = viewModel.firstCountryFlag
        secondCountryImage?.image = viewModel.secondCountryFlag
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
