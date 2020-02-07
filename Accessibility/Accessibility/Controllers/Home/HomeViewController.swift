//
//  ViewController.swift
//  Accessibility
//
//  Created by Marina Miranda Aranha on 30/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var calendarStackHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    struct JSON: Decodable {
        let model: [Discipline]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        json = jsonManager.loadJSONFile()
        setSportsOfTheDay(day: 22)
        //load card infos
        
        setCalendarStackHeight()
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(fontChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
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
        print(size)
        if size < 18 {
            self.calendarStackHeight.constant = 90
            self.collectionViewLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        } else if size > 18 && size <= 27 {
            self.calendarStackHeight.constant = 125
            self.collectionViewLayout.sectionInset = UIEdgeInsets(top: 8, left: 25, bottom: 8, right: 25)
        } else if size > 27 && size <= 40 {
            self.calendarStackHeight.constant = 160
            self.collectionViewLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        } else if size > 40 {
            self.calendarStackHeight.constant = 250
            self.collectionViewLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
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
                
                return cell
            }
            
        } else {
            // Setting sports cells
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier,
                                                             for: indexPath) as? CollectionViewCell {
                let sportName = sportsOfTheDayDisplayNames[indexPath.row]
                let iconName = getIcon(sport: sportName)
                cell.configureCell(sportImage: iconName, sport: sportName)
                
                
                // Configure the cell
                cell.layer.borderWidth = 1
                cell.layer.borderColor = UIColor.clear.cgColor
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOffset = CGSize(width: 0, height: 0)
                cell.layer.shadowRadius = 8.0
                cell.layer.shadowOpacity = 0.2
                cell.layer.masksToBounds = false
                
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

