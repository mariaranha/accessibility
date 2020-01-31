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
    
    //Navigation bar title
    var sportTitle: String = "Boxe"
    
    //Card Labels
    var matchTitle: [String] = []
    var subtitle: [String] = []
    var numberOfPoints: [String] = []
    var firstCountryText: [String] = []
    var secondCountryText: [String] = []
    var dayText: [String] = []
    var monthText: [String] = []
    var timeText: [String] = []
    
    //Card Images
    var cornerImage: [UIImage] = []
    var firstCountryFlag: [UIImage] = []
    var secondCountryFlag: [UIImage] = []
    var emptyFlag = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyFlag = UIImage(named: "empty-flag") ?? UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
        
        //POPOULATE CARDS
        
        //Card Labels
        matchTitle = ["Feminino", "Masculino"]
        subtitle = ["Peso Mosca (48-51kg) - Eliminatórias", "Peso Galo (56kg) - Quartas de final"]
        numberOfPoints = ["–","30"]
        firstCountryText = ["BRA", "USA"]
        secondCountryText = ["CHN", "PAK"]
        dayText = ["24", "24"]
        monthText = ["JUN", "JUN"]
        timeText = ["09:30", "01:00"]
        
        //Card Images
        cornerImage = []
        firstCountryFlag = [UIImage(named: "brazil-flag-xl") ?? emptyFlag, UIImage(named: "united-states-of-america-flag-xl") ?? emptyFlag]
        secondCountryFlag = [UIImage(named: "china-flag-xl") ?? emptyFlag, UIImage(named: "pakistan-flag-xl") ?? emptyFlag]
        
    }
}


extension SportMatchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = matchesTableView.dequeueReusableCell(withIdentifier: "cardCell") as! CardTableViewCell
        
        //Card Labels
        cell.titleLabel.text = matchTitle[indexPath.row]
        cell.subtitleLabel.text = subtitle[indexPath.row]
        cell.numberOfPointsLabel.text = numberOfPoints[indexPath.row]
        cell.firstCountryLabel.text = firstCountryText[indexPath.row]
        cell.secondCountryLabel.text = secondCountryText[indexPath.row]
        cell.dayLabel.text = dayText[indexPath.row]
        cell.monthLabel.text = monthText[indexPath.row]
        cell.timeLabel.text = timeText[indexPath.row]
        
        //Card Images
        cell.firstCountryImage.image = firstCountryFlag[indexPath.row]
        cell.secondCountryImage.image = secondCountryFlag[indexPath.row]
        
        return cell
    }
    
}
