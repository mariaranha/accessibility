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
    
    //Card View Model
    var cardsViewModel: [CardView.ViewModel] = []
    var cardsDynamicViewModel: [CardViewDynamic.ViewModel] = []
    
    //Large fonte
    var isLargeFont: Bool = false
    
    //Card detail Presenter
    private let detailPresenter = CardDetailPresenter()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Notification for change of font size
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(fontChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Check font
        checkFontSize()
        cardDetailTableView.reloadData()
        
//        cardsDynamicViewModel = presenter.formatCardsDynamic()
//               cardsViewModel = presenter.formatCards()
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
