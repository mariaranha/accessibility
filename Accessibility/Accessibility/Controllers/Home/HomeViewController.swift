//
//  ViewController.swift
//  Accessibility
//
//  Created by Marina Miranda Aranha on 30/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let weekDays = ["S", "T", "Q", "Q", "S", "S", "D"]
    let days = ["22", "23", "24", "25", "26", "27", "28", "29", "30", "31",
                "01", "02", "03", "04", "05", "06", "07", "08", "09"]
    
    var monthDay: Int!
    var json: [Discipline] = []
    var disciplinesOfTheDay: [Discipline] = []
    var sportsOfTheDay: [String] = []
    let jsonManager = JSONManager()
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    @IBOutlet weak var calendarStackHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var dayLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.monthDay = getMonthDay()
        
        setCalendarStackHeight()
        
        let nc = NotificationCenter.default
        
        nc.addObserver(self, selector: #selector(fontChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
        
    }
    
    deinit {
        let nc = NotificationCenter.default

        nc.removeObserver(self, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @objc func fontChanged(_ notification: Notification) {
        print("fontChanged")
        
        setCalendarStackHeight()
    }
    
    func setCalendarStackHeight(){
        var userFontSize = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        var size = userFontSize.pointSize
                
        if size <= 20 {
            self.calendarStackHeight.constant = 90
        //    self.selectedImageTop.constant = 26
        } else if size > 20 && size <= 30 {
            self.calendarStackHeight.constant = 125
       //     self.selectedImageTop.constant = 30
        } else if size > 30 && size <= 40 {
            self.calendarStackHeight.constant = 160
        //    self.selectedImageTop.constant = 32
        } else if size > 40 {
            self.calendarStackHeight.constant = 250
        //    self.selectedImageTop.constant = 34
        }
        
        self.collectionView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        json = jsonManager.loadJSONFile()
        loadSportsOfTheDay(day: self.monthDay)
        printSportsOfTheDay()
    }
    
    // MARK: - Collection View functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == calendarCollectionView {
            return days.count
        } else {
            return 5
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == calendarCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier,
            for: indexPath) as? CalendarCollectionViewCell {
                let day = days[indexPath.row]
                let weekDay = weekDays[indexPath.row % 7]
                cell.configureCell(weekDay: weekDay, day: day)
                
                if Int(day) == 22{
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
                    
                } else {
                    cell.selectDay(isSelected: false)
                }
                
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell {
                           
                           
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    // MARK: - JSON Functions
    
    private func loadSportsOfTheDay(day: Int) {
        for discipline in self.json {
            for disciplineDay in discipline.normalDates {
                if disciplineDay == day {
                    self.disciplinesOfTheDay.append(discipline)
                    self.sportsOfTheDay.append(discipline.sport)
                }
            }
            
            for disciplineDay in discipline.medalDates {
                if disciplineDay  == day {
                    self.disciplinesOfTheDay.append(discipline)
                    self.sportsOfTheDay.append(discipline.sport)
                }
            }
        }
    }
    
    // MARK: - Months of the day
    
    private func getMonthDay() -> Int {
        // Return the user current month day
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let monthDay = components.day
        return monthDay ?? 32
    }
    
    private func printSportsOfTheDay() {
        // Removing duplicated sports
        let unique = Array(Set(self.sportsOfTheDay)).sorted()
        
        for sport in unique {
            print(sport)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == calendarCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
                cell.selectDay(isSelected: true)
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
            
            
            
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == calendarCollectionView{
            if let cell = collectionView.cellForItem(at: indexPath) as? CalendarCollectionViewCell {
                cell.selectDay(isSelected: false)

            }
        } 
    }

}

