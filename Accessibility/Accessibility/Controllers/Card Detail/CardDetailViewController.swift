//
//  CardDetailViewController.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 07/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
    
    @IBOutlet weak var cardDetailTableView: UITableView!
    
    //Card infos
    var cardTitle: String = ""
    var subtitle: String = ""
    var numberOfPoints: String = ""
    var firstCountryName: String = ""
    var secondCountryName: String = ""
    var day: String = ""
    var month: String = ""
    var time: String = ""
    var date: String = ""
    var cornerImage = UIImage()
    var firstCountryFlag = UIImage()
    var secondCountryFlag = UIImage()
    
    //Card View Model
    var cardsViewModel: CardView.ViewModel!
    var cardsDynamicViewModel: CardViewDynamic.ViewModel!
    
    //Large fonte
    var isLargeFont: Bool = false
    
    //Card detail Presenter
    private let presenter = CardDetailPresenter()
    
    var emptyFlag = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Notification for change of font size
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(fontChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let footerView = UIView()
        cardDetailTableView.tableFooterView = footerView
        
        //Check font
        checkFontSize()
        cardDetailTableView.reloadData()
        
        cardsDynamicViewModel = presenter.formatCardsDynamic(title: cardTitle,
                                                             subtitle: subtitle,
                                                             numberOfPoints: numberOfPoints,
                                                             firstCountryName: firstCountryName,
                                                             secondCountryName: secondCountryName,
                                                             date: "\(day) \(month) \(time)",
                                                             firstCountryFlag: firstCountryFlag,
                                                             secondCountryFlag: secondCountryFlag)
        
        cardsViewModel = presenter.formatCards(title: cardTitle,
                                               subtitle: subtitle,
                                               numberOfPoints: numberOfPoints,
                                               firstCountryName: firstCountryName,
                                               secondCountryName: secondCountryName,
                                               day: day,
                                               month: month,
                                               time: time,
                                               cornerImage: cornerImage,
                                               firstCountryFlag: firstCountryFlag,
                                               secondCountryFlag: secondCountryFlag)
        
        let nibDynamic = UINib.init(nibName: "CardViewDynamic", bundle: nil)
            self.cardDetailTableView.register(nibDynamic, forCellReuseIdentifier: "cardViewDynamic")
        
            let nib = UINib.init(nibName: "CardView", bundle: nil)
            self.cardDetailTableView.register(nib, forCellReuseIdentifier: "cardView")
            
            emptyFlag = UIImage(named: "empty-flag") ?? UIImage()
    }
    
    @objc func fontChanged(_ notification: Notification) {
        checkFontSize()
        cardDetailTableView.setNeedsLayout()
    }
    
    //Remove notification for change of font
    deinit {
    let nc = NotificationCenter.default

      nc.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    fileprivate func checkFontSize() {
        let textSize = traitCollection.preferredContentSizeCategory
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        
        //Change card view - Text to large
        if isAccessibilityCategory && textSize != .accessibilityMedium {
            isLargeFont = true
            
        } else {
            isLargeFont = false
            
        }
    }
}

extension CardDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CARD
        if indexPath.row == 0 {
            
            if isLargeFont {
                guard let cell = cardDetailTableView.dequeueReusableCell(withIdentifier: "cardCellDynamic") as? CardTableViewCell else { return UITableViewCell() }
                cell.configureDynamic(with: cardsDynamicViewModel)

                return cell
            } else {
                guard let cell = cardDetailTableView.dequeueReusableCell(withIdentifier: "cardCell") as? CardTableViewCell else { return UITableViewCell() }
                cell.configure(with: cardsViewModel)
                return cell
            }
            
        //RESULT LABEL
        } else if indexPath.row == 1 {
            guard let cell = cardDetailTableView.dequeueReusableCell(withIdentifier: "resultCell") as? ResultTableViewCell else { return UITableViewCell() }

            cell.title.text = "RESULTADO"
            return cell
            
        //RANKING CELL
        } else {
            guard let cell = cardDetailTableView.dequeueReusableCell(withIdentifier: "rankingTeamCell") as? RankingTeamTableViewCell else { return UITableViewCell() }
            cell.countryFlag1.image = firstCountryFlag
            cell.countryFlag2.image = secondCountryFlag
            cell.countryName1.text = firstCountryName
            cell.countryName2.text = secondCountryName
            cell.result.text = "3:0"
            cell.gameTitle.text = "\(cardTitle) \(subtitle)"
            
            return cell
        }
        
    }

    
}
