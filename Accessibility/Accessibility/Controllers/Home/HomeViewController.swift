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
    let days = ["27", "28", "29", "30", "31", "01", "02", "03", "04", "05"]
    
    var monthDay: Int!
    var json: [Discipline] = []
    var disciplinesOfTheDay: [Discipline] = []
    var sportsOfTheDay: [String] = []
    let jsonManager = JSONManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.monthDay = getMonthDay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        json = jsonManager.loadJSONFile()
        loadSportsOfTheDay(day: self.monthDay)
        printSportsOfTheDay()
    }
    
    // MARK: - Collection View functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier,
        for: indexPath) as? CalendarCollectionViewCell {
            let day = days[indexPath.row]
            cell.configureCell(weekDay: "S", day: day)
            return cell
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
}

