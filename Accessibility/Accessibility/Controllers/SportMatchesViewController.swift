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
    
    //Corner colors
    var cornerColors = [UserCornerImage.blue,
                        UserCornerImage.yellow,
                        UserCornerImage.black,
                        UserCornerImage.green,
                        UserCornerImage.red]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyFlag = UIImage(named: "empty-flag") ?? UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Reload if needed
        matchesTableView.reloadData()
        
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
        
        //Card Labels - CHANGE
        matchTitle = ["Feminino", "Masculino", "Teste", "Teste", "Teste", "Teste", "Teste"]
        subtitle = ["Peso Mosca (48-51kg) - Eliminatórias", "Peso Galo (56kg) - Quartas de final", "Teste", "Teste", "Teste", "Teste", "Teste"]
        numberOfPoints = ["–","30", "40", "50", "60", "30", "–"]
        firstCountryText = ["BRA", "USA", "BLA", "BLA", "BLA", "BLA", "BLA"]
        secondCountryText = ["CHN", "PAK", "BLA", "BLA", "BLA", "BLA", "BLA"]
        dayText = ["24", "24", "23", "04", "09", "12", "20"]
        monthText = ["JUN", "JUN", "BLA", "BLA", "BLA", "BLA", "BLA", ]
        timeText = ["09:30", "01:00", "09:30", "01:00", "09:30", "01:00", "01:00"]
        
        //Card Images - CHANGE
        cornerImage = []
        firstCountryFlag = [UIImage(named: "brazil-flag-xl") ?? emptyFlag,
                            UIImage(named: "united-states-of-america-flag-xl") ?? emptyFlag,
                            UIImage(named: "brazil-flag-xl") ?? emptyFlag,
                            UIImage(named: "united-states-of-america-flag-xl") ?? emptyFlag,
                            UIImage(named: "brazil-flag-xl") ?? emptyFlag,
                            UIImage(named: "united-states-of-america-flag-xl") ?? emptyFlag,
                            UIImage(named: "brazil-flag-xl") ?? emptyFlag]
        
        secondCountryFlag = [UIImage(named: "china-flag-xl") ?? emptyFlag,
                             UIImage(named: "pakistan-flag-xl") ?? emptyFlag,
                             UIImage(named: "china-flag-xl") ?? emptyFlag,
                             UIImage(named: "pakistan-flag-xl") ?? emptyFlag,
                             UIImage(named: "china-flag-xl") ?? emptyFlag,
                             UIImage(named: "pakistan-flag-xl") ?? emptyFlag,
                             UIImage(named: "pakistan-flag-xl") ?? emptyFlag]
        
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
        
        //When is set to corlorful corner mode
        let cornerDefaultColor = UserDefaultsStruct.CornerMode.color
        
        if cornerDefaultColor == "colorful" {
            colorfulCorner()
            cell.cornerImage.image = cornerImage[indexPath.row]
            
        //Set one color only
        } else {
            for _ in 0...(matchTitle.count - 1) {
                var cornerImg = UIImage()
                cornerImageName(UserCornerImage(rawValue: cornerDefaultColor) ?? UserCornerImage.red, &cornerImg)
                cornerImage.append(cornerImg)
            }
            
            cell.cornerImage.image = cornerImage[indexPath.row]
        }
        
        
        return cell
    }
    
    func colorfulCorner() {
        //Card Corner Image - For colorfull mode
        let numberOfMatches = matchTitle.count
        var randomNumber = Int.random(in: 0...4)
        
        for _ in 0...(numberOfMatches - 1) {
            
            if randomNumber < 4 {
                randomNumber += 1
            } else {
                randomNumber = 0
            }
            
            let corner = cornerColors[randomNumber]
            var cornerImg = UIImage()
            
            //Set the image for each case
            cornerImageName(corner, &cornerImg)
            
            cornerImage.append(cornerImg)
        }
    }
    
    func cornerImageName(_ corner: UserCornerImage, _ cornerImg: inout UIImage) {
        switch corner {
        case .blue:
            cornerImg = UIImage(named: "corner-blue") ?? UIImage()
        case .yellow:
            cornerImg = UIImage(named: "corner-yellow") ?? UIImage()
        case .black:
            cornerImg = UIImage(named: "corner-black") ?? UIImage()
        case .green:
            cornerImg = UIImage(named: "corner-green") ?? UIImage()
        case .red:
            cornerImg = UIImage(named: "corner-red") ?? UIImage()
        case .colorfull:
            break
        }
    }
    
}
