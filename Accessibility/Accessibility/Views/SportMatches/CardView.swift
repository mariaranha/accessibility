import UIKit
import Foundation

final class CardView: UIView {

    @IBOutlet var contentView: UIView!
    
    //Card Labels
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var pointsLabel: UILabel?
    @IBOutlet weak var numberOfPointsLabel: UILabel?
    @IBOutlet weak var firstCountryLabel: UILabel?
    @IBOutlet weak var secondCountryLabel: UILabel?
    @IBOutlet weak var dayLabel: UILabel?
    @IBOutlet weak var monthLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    
    //Card Images
    @IBOutlet weak var ringImage: UIImageView?
    @IBOutlet weak var cornerImage: UIImageView?
    @IBOutlet weak var firstCountryImage: UIImageView?
    @IBOutlet weak var secondCountryImage: UIImageView?
    
    //Button
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
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
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
        dayLabel?.text = viewModel.day
        monthLabel?.text = viewModel.mounth
        timeLabel?.text = viewModel.time
        
        cornerImage?.image = viewModel.cornerImage
        firstCountryImage?.image = viewModel.firstCountryFlag
        secondCountryImage?.image = viewModel.secondCountryFlag
    }
}

extension CardView {
    struct ViewModel {
        let title: String
        let subtitle: String
        let numberOfPoints: String
        let firstCountryName: String
        let secondCountryName: String
        let day: String
        let mounth: String
        let time: String
        let cornerImage: UIImage
        let firstCountryFlag: UIImage
        let secondCountryFlag: UIImage
    }
}
