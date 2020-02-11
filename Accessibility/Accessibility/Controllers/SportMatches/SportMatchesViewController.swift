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
    
    // Json
    var sportsOfTheDay: [Discipline]!
    var discipline: Discipline!
    var matchDay: Int!
    var dayOnly: Bool = true
    
    //Navigation bar title - CHANGE
    var sportTitle: String = "Boxe"
    
    //Card View Model
    var cardsViewModel: [CardView.ViewModel] = []
    var cardsDynamicViewModel: [CardViewDynamic.ViewModel] = []
    
    //Large fonte
    var isLargeFont: Bool = false
    
    //Sport Matches Presenter
    private let presenter = SportMatchesPresenter()
    
    //Selected card info
    var selectedCard: CardView.ViewModel!
    var selectedDynamicCard: CardViewDynamic.ViewModel!
    
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
        matchesTableView.reloadData()
        
       
        var date = "\(String(self.matchDay)) \(returnMounth(day: self.matchDay)) 12:30"
        
        if dayOnly {
            
            let sportsNumber: Int = sportsOfTheDay.count
            
            for i in 0...sportsNumber-1 {
            
                cardsDynamicViewModel = presenter.formatCardsDynamic(title: sportsOfTheDay[i].name,
                                                                     subtitle: sportsOfTheDay[i].sport,
                                                                     numberOfPoints: "–",
                                                                     firstCountryName: "BRA",
                                                                     secondCountryName: "CHN",
                                                                     date: date,
                                                                     viewModelArray: cardsDynamicViewModel)
                
                cardsViewModel = presenter.formatCards(title: sportsOfTheDay[i].name,
                                                       subtitle: sportsOfTheDay[i].sport,
                                                       numberOfPoints: "–",
                                                       firstCountryName: "BRA",
                                                       secondCountryName: "CHN",
                                                       day: String(self.matchDay),
                                                       mounth: returnMounth(day: self.matchDay),
                                                       time: "12:00",
                                                       index: sportsNumber,
                                                       viewModelArray: cardsViewModel)
            }
            
        } else {
            
            for day in self.discipline.allDates {
                    
                    date = "\(String(day)) \(returnMounth(day: day)) 12:30"
                    
                cardsDynamicViewModel = presenter.formatCardsDynamic(title: self.discipline.name,
                                                                     subtitle: self.discipline.sport,
                                                                     numberOfPoints: "–",
                                                                     firstCountryName: "BRA",
                                                                     secondCountryName: "CHN",
                                                                     date: date,
                                                                     viewModelArray: cardsDynamicViewModel)
                    
                cardsViewModel = presenter.formatCards(title: self.discipline.name,
                                                       subtitle: self.discipline.sport,
                                                       numberOfPoints: "–",
                                                       firstCountryName: "BRA",
                                                       secondCountryName: "CHN",
                                                       day: String(day),
                                                       mounth: returnMounth(day: day),
                                                       time: "12:00",
                                                       index: 1,
                                                       viewModelArray: cardsViewModel)
                    
                    
                }
        }
        
        let nibDynamic = UINib.init(nibName: "CardViewDynamic", bundle: nil)
        self.matchesTableView.register(nibDynamic, forCellReuseIdentifier: "cardViewDynamic")
    
        let nib = UINib.init(nibName: "CardView", bundle: nil)
        self.matchesTableView.register(nib, forCellReuseIdentifier: "cardView")
        
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
        matchesTableView.setNeedsLayout()
    }
    
    //Remove notification for change of font
    deinit {
    let nc = NotificationCenter.default

      nc.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    private func returnMounth(day: Int) -> String {
        let august: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        if (august.contains(day)) {
            return "AUG"
        } else {
            return "JUN"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cardDetail" {
            let cd = segue.destination as? CardDetailViewController

            if isLargeFont {
                cd?.cardTitle = selectedDynamicCard.title
                cd?.subtitle = selectedDynamicCard.subtitle
                cd?.numberOfPoints = selectedDynamicCard.numberOfPoints
                cd?.date = selectedDynamicCard.date
                cd?.firstCountryName = selectedDynamicCard.firstCountryName
                cd?.secondCountryName = selectedDynamicCard.secondCountryName
                cd?.firstCountryFlag = selectedDynamicCard.firstCountryFlag
                cd?.secondCountryFlag = selectedDynamicCard.secondCountryFlag
            } else {
                cd?.cardTitle = selectedCard.title
                cd?.subtitle = selectedCard.subtitle
                cd?.numberOfPoints = selectedCard.numberOfPoints
                cd?.day = selectedCard.day
                cd?.month = selectedCard.mounth
                cd?.time = selectedCard.time
                cd?.cornerImage = selectedCard.cornerImage
                cd?.firstCountryName = selectedCard.firstCountryName
                cd?.secondCountryName = selectedCard.secondCountryName
                cd?.firstCountryFlag = selectedCard.firstCountryFlag
                cd?.secondCountryFlag = selectedCard.secondCountryFlag
            }

        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isLargeFont {
            let dynamicCard = cardsDynamicViewModel[indexPath.row]
            selectedDynamicCard = dynamicCard
        } else {
            let card = cardsViewModel[indexPath.row]
            selectedCard = card
        }
        
        performSegue(withIdentifier: "cardDetail", sender: nil)
    
    }
}
