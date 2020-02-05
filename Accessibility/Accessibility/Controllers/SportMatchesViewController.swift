//
//  SportMatchesViewController.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class SportMatchesViewController: UIViewController {
    
    @IBOutlet weak var matchesTableView: UITableView!
    
    //Navigation bar title - CHANGE
    var sportTitle: String = "Boxe"
    
    //Card View Model
    var cardsViewModel: [CardView.ViewModel] = []
    var cardsDynamicViewModel: [CardViewDynamic.ViewModel] = []
    
    //Large fonte
    var isLargeFont: Bool = false
    
    //Sport Matches Presenter
    private let presenter = SportMatchesPresenter()
    
    var emptyFlag = UIImage()

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
        
        cardsDynamicViewModel = presenter.formatCardsDynamic()
        cardsViewModel = presenter.formatCards()
        
        let nibDynamic = UINib.init(nibName: "CardViewDynamic", bundle: nil)
        self.matchesTableView.register(nibDynamic, forCellReuseIdentifier: "cardViewDynamic")
    
        let nib = UINib.init(nibName: "CardView", bundle: nil)
        self.matchesTableView.register(nib, forCellReuseIdentifier: "cardView")
        
        matchesTableView.reloadData()
        
        emptyFlag = UIImage(named: "empty-flag") ?? UIImage()
        
        //Changing status bar color
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = UIColor.white
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        //Removing line in navigation bar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Navigatin Bar Title
        self.title = sportTitle
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
    
    @objc func fontChanged(_ notification: Notification) {
        checkFontSize()
        matchesTableView.reloadData()
    }
    
    //Remove notification for change of font
    deinit {
    let nc = NotificationCenter.default

      nc.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
}


extension SportMatchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLargeFont {
            return cardsDynamicViewModel.count
        } else {
            return cardsViewModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLargeFont {
            guard let cell = matchesTableView.dequeueReusableCell(withIdentifier: "cardCellDynamic") as? CardTableViewCell else { return UITableViewCell() }
            let viewModel = cardsDynamicViewModel[indexPath.row]
            cell.configureDynamic(with: viewModel)
            
            return cell
        } else {
            guard let cell = matchesTableView.dequeueReusableCell(withIdentifier: "cardCell") as? CardTableViewCell else { return UITableViewCell() }
            let viewModel = cardsViewModel[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    
}
