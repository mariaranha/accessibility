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
    
    //Flag view constraits
    @IBOutlet weak var firstCountryWidth: NSLayoutConstraint!
    @IBOutlet weak var secondCountryWidth: NSLayoutConstraint!
    
    //Buttons
    @IBOutlet weak var firstCountryButton: UIButton!
    @IBOutlet weak var secondCountryButton: UIButton!
    
    //Bet variables
    var isFirstCountrySelected: Bool = false
    var isSecondCountrySelected: Bool = false
    let widthMultiplier: CGFloat = 1.8
    
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
        let pointsTitle = NSLocalizedString("Points", comment: "User points in the game")
        self.pointsLabel?.text = pointsTitle
    }
    
    @IBAction func firstCountrySelected(_ sender: UIButton) {
        let firstFlagWidth = firstCountryWidth.constant
        let secondFlagWidth = secondCountryWidth.constant
        
        if isFirstCountrySelected == false && isSecondCountrySelected == false {
            isFirstCountrySelected = !isFirstCountrySelected
            secondCountryButton.backgroundColor = .white
            secondCountryButton.alpha = 0.6
            
            firstCountryWidth.constant = firstFlagWidth * widthMultiplier
            
        } else if isFirstCountrySelected == true && isSecondCountrySelected == false {
            isFirstCountrySelected = !isFirstCountrySelected
            secondCountryButton.backgroundColor = .clear
            secondCountryButton.alpha = 1.0
            
            firstCountryWidth.constant = firstFlagWidth / widthMultiplier
            
        } else if isFirstCountrySelected == false && isSecondCountrySelected == true {
            isFirstCountrySelected = !isFirstCountrySelected
            isSecondCountrySelected = !isSecondCountrySelected
            firstCountryButton.backgroundColor = .clear
            firstCountryButton.alpha = 1.0
            
            secondCountryButton.backgroundColor = .white
            secondCountryButton.alpha = 0.6
            
            firstCountryWidth.constant = firstFlagWidth * widthMultiplier
            secondCountryWidth.constant = secondFlagWidth / widthMultiplier
        }
    }
    
    
    @IBAction func secondCountrySelected(_ sender: UIButton) {
        let firstFlagWidth = firstCountryWidth.constant
        let secondFlagWidth = secondCountryWidth.constant
        
        if isFirstCountrySelected == false && isSecondCountrySelected == false {
            isSecondCountrySelected = !isSecondCountrySelected
            firstCountryButton.backgroundColor = .white
            firstCountryButton.alpha = 0.6
            
            secondCountryWidth.constant = secondFlagWidth * widthMultiplier
            
        } else if isFirstCountrySelected == false && isSecondCountrySelected == true {
            isSecondCountrySelected = !isSecondCountrySelected
            firstCountryButton.backgroundColor = .clear
            firstCountryButton.alpha = 1.0
            
            secondCountryWidth.constant = secondFlagWidth / widthMultiplier
            
        } else if isFirstCountrySelected == true && isSecondCountrySelected == false {
            isSecondCountrySelected = !isSecondCountrySelected
            isFirstCountrySelected = !isFirstCountrySelected
            secondCountryButton.backgroundColor = .clear
            secondCountryButton.alpha = 1.0
            
            firstCountryButton.backgroundColor = .white
            firstCountryButton.alpha = 0.6
            
            firstCountryWidth.constant = firstFlagWidth / widthMultiplier
            secondCountryWidth.constant = secondFlagWidth * widthMultiplier
        }
    }
    
    
    func configure(with viewModel: ViewModel) {
        titleLabel?.text = viewModel.title
        titleLabel?.sizeToFit()
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
    @IBAction func firstCountryTapped(_ sender: Any) {
        firstCountryButton.isAccessibilityElement = true
        if isFirstCountrySelected == false{
            firstCountryButton?.accessibilityHint = String(format: NSLocalizedString("You throbbed at Brazil", comment: ""))
        } else {
            firstCountryButton?.accessibilityHint = String(format: NSLocalizedString("Double tap to throb at Brazil", comment: ""))
        }
    }
    @IBAction func secondCountryTapped(_ sender: Any) {
         secondCountryButton.isAccessibilityElement = true
          if isSecondCountrySelected == false{
               firstCountryButton?.accessibilityHint = String(format: NSLocalizedString("You throbbed at China", comment: ""))
           } else {
               firstCountryButton?.accessibilityHint = String(format: NSLocalizedString("Double tap to throb at China", comment: ""))
        }
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
