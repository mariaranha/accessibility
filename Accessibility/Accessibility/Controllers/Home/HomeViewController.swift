//
//  ViewController.swift
//  Accessibility
//
//  Created by Marina Miranda Aranha on 30/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var monthDay: Int!
    let weekDays = ["S", "T", "Q", "Q", "S", "S", "D"]
    let days = ["22", "23", "24", "25", "26", "27", "28", "29", "30", "31",
                "01", "02", "03", "04", "05", "06", "07", "08", "09"]
    
    var selectedDay: Int!
    var json: [Discipline] = []
    var selectedSport: String!
    var sportsOfTheDayDisplayNames: [String] = []
    var sportsOfTheDay: [Discipline] = []
    var sportsNumber: Int!
    let jsonManager = JSONManager()
    var disciplinesOfTheDay: [Discipline] = []
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    @IBOutlet weak var dayStackView: UIStackView!
    
    @IBOutlet weak var calendarStackHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        json = jsonManager.loadJSONFile()
        setSportsOfTheDay(day: 22)
        
        // Setting view controller title based
        // on user system language
        let viewControllerTitle = NSLocalizedString("Sports of the day",
                                                    comment: "This represents the home title: 'sports of the day'")
        self.title = viewControllerTitle
        
        setCalendarStackHeight()
        
        
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(fontChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
        
        DispatchQueue.main.async {
            self.collectionView.collectionViewLayout.invalidateLayout()

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.monthDay = getMonthDay()
        
        self.collectionViewLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        self.collectionViewLayout.minimumLineSpacing = 10
        
    }
    
    private func printSportsOfTheDay() {
        
        // Removing duplicated sports
        
        let unique = Array(Set(self.sportsOfTheDayDisplayNames)).sorted()
        
        for sport in unique {
            print(sport)
        }
    }
    
     // This function will be used when we
     // reach the olympic games
    private func getMonthDay() -> Int {
        // Return the user current month day
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let monthDay = components.day
        return monthDay ?? 32
    }
    
    deinit {
        let nc = NotificationCenter.default

        nc.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @objc func fontChanged(_ notification: Notification) {
        
        setCalendarStackHeight()

    }
    
    func setCalendarStackHeight(){
        let userFontSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        let size = userFontSize.pointSize
        if size < 18 {
            self.calendarStackHeight.constant = 90
        } else if size > 18 && size <= 27 {
            self.calendarStackHeight.constant = 125
        } else if size > 27 && size <= 40 {
            self.calendarStackHeight.constant = 160
        } else if size > 40 {
            self.calendarStackHeight.constant = 210
            
            for cell in collectionView.visibleCells as! [CollectionViewCell]{
                cell.labelWidth.constant = 200
            }
            
        }
        
        
        DispatchQueue.main.async {
            self.collectionView.collectionViewLayout.invalidateLayout()

        }
        
    }
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == calendarCollectionView {
            return days.count
        } else {
            return sportsNumber
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == calendarCollectionView {
            // Setting calendar cells
            
            let userFontSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
            let size = userFontSize.pointSize
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier,
                                                             for: indexPath) as? CalendarCollectionViewCell {
                let day = days[indexPath.row]
                let weekDay = weekDays[indexPath.row % 7]
                cell.configureCell(weekDay: weekDay, day: day)
                
                if Int(day) == 22 {
                    collectionView.selectItem(at: indexPath, animated: true,
                                              scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
                    
                } else {
                    cell.selectDay(isSelected: false)
                }
                
                if size > 40{
                    cell.dayStack.spacing = 0
                    cell.selectedImage.image?.size
                }
                
                return cell
            }
            
        } else {
            // Setting sports cells
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier,
                                                             for: indexPath) as? CollectionViewCell {
                
                
                cell.contentView.layer.cornerRadius = 8
                cell.layer.borderWidth = 0
                cell.layer.borderColor = UIColor.lightGray.cgColor

                cell.layer.backgroundColor = UIColor.white.cgColor
                cell.layer.shadowColor = UIColor.gray.cgColor
                cell.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
                cell.layer.shadowOpacity = 0.2
                cell.layer.masksToBounds = false
                
                let sportName = sportsOfTheDayDisplayNames[indexPath.row]
                let iconName = getIcon(sport: sportName)
                cell.configureCell(sportImage: iconName, sport: sportName)
                cell.contentView.isAccessibilityElement = true
                cell.contentView.accessibilityLabel = NSLocalizedString ("Modalidade \(sportName)", comment: "Modalidade do Esporte")
                cell.contentView.accessibilityHint = NSLocalizedString ("Clique para acessar os jogos dessa modalidade", comment: "Selecionar o card")

                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == calendarCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
                cell.selectDay(isSelected: true)
                
                let tappedDay = Int(cell.dayLabel.text!)!
                setSportsOfTheDay(day: tappedDay)
                self.collectionView.reloadData()
                
                var month: String!
                var day = Int(cell.dayLabel.text!)!
                if day < 10 {
                    month = "Agosto"
                } else {
                    month = "Julho"
                }
                self.dayLabel.text = "\(day) de \(month!) de 2020"

            }
        } else {
            
            // Getting selected sport name to populate the next view
            if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                self.selectedSport = cell.sportNameLabel.text
                
                let userFontSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
                let size = userFontSize.pointSize
                var cellWidth: CGFloat?
                
                if size > 33 {
                    cell.labelWidth.constant = 200
                    DispatchQueue.main.async {
                        self.collectionView.collectionViewLayout.invalidateLayout()

                    }
                }
                
                performSegue(withIdentifier: "goToCards", sender: nil)
            }
            
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == calendarCollectionView{
            if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
                cell.selectDay(isSelected: false)

            }
        }
    }
    

    
    // MARK: - Loading icons
    
    private func getIcon(sport: String) -> UIImage {
        // Returns the icon of the sport passed as parameter
        
        let defaultIcon: UIImage = UIImage(named: "soccer-icon")!
        
        if let icon = UIImage(named: "\(sport)-icon") {
            return icon
        }
        
        return defaultIcon
    }
    
    // MARK: - JSON Functions
    
    private func loadSportsOfTheDay(day: Int) -> [Discipline] {
        // Loads all sports of the day
        
        var sports: [Discipline] = []
        for discipline in self.json {
            for disciplineDay in discipline.normalDates {
                if disciplineDay == day {
                    sports.append(discipline)
                }
            }
            for disciplineDay in discipline.medalDates {
                if disciplineDay  == day {
                    sports.append(discipline)
                }
            }
        }
        
        return sports
    }
    
    private func getSportsDisplayArray(sportsOfTheDay: [Discipline]) -> [String] {
        var sports: [String] = []
        
        for discilpine in sportsOfTheDay {
            sports.append(discilpine.sport)
        }
        
        return sports
    }

    // MARK: - Setting sports of the day
    
    private func setSportsOfTheDay(day: Int) {

        self.selectedDay = day
        self.sportsOfTheDay = loadSportsOfTheDay(day: day)
        self.sportsOfTheDayDisplayNames = getSportsDisplayArray(sportsOfTheDay: self.sportsOfTheDay)
        self.sportsNumber = sportsOfTheDayDisplayNames.count
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToCards") {
            if let nextVC = segue.destination as? SportMatchesViewController {
                nextVC.sportsOfTheDay = getSelectedSportOnly(sportsOfTheDay: self.sportsOfTheDay, selectedSport: self.selectedSport)
                nextVC.sportTitle = self.selectedSport ?? ""
                nextVC.matchDay = self.selectedDay
            }
        }
    }
    
    private func getSelectedSportOnly(sportsOfTheDay: [Discipline], selectedSport: String) -> [Discipline] {
        
        var selectedSportArray: [Discipline] = []
        
        for element in sportsOfTheDay {
            if (element.sport.capitalized == selectedSport) {
                selectedSportArray.append(element)
            }
        }
        
        return selectedSportArray
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // if collectionView == collectionView{
        let userFontSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        let size = userFontSize.pointSize
        var cellWidth: CGFloat?
        
        print(size)
        if collectionView == self.collectionView{
            if size < 21 {
                cellWidth = (self.view.frame.width / 3)
                return CGSize(width: cellWidth! , height: cellWidth! + 20)
            }else if size >= 21 && size < 33{
                cellWidth = (self.view.frame.width / 2)
                return CGSize(width: cellWidth! - 15, height: cellWidth! + 15)
            } else if size == 33{
                cellWidth = (self.view.frame.width / 2)
                return CGSize(width: cellWidth! - 10, height: cellWidth! + 35)
            } else {
                cellWidth = self.view.frame.width
                return CGSize(width: cellWidth! - 40, height: cellWidth! - 40)
            }
        } else {
            return CGSize(width:5, height: 5)
        }
    }
}
