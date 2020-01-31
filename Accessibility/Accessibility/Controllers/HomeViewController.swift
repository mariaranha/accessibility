//
//  ViewController.swift
//  Accessibility
//
//  Created by Marina Miranda Aranha on 30/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var monthDay: Int!
    var json: [Discipline] = []
    var disciplinesOfTheDay: [Discipline] = []
    var sportsOfTheDay: [String] = []
    
    struct JSON: Decodable {
        let model: [Discipline]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.monthDay = getMonthDay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        loadJSONFile()
        loadSportsOfTheDay(day: self.monthDay)
        printSportsOfTheDay()
    }

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
    
    // MARK: - JSON Functions
    
    private func loadJSONFile() {
        // Loading JSON file and building and building JSON array.
        if let url = Bundle.main.url(forResource: "calendar", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url, options: .mappedIfSafe)
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: jsonData,
                                        options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary {
                        if let disciplinesArray = jsonResult.value(forKey: "discipline") as? NSArray {
                            for (_, element) in disciplinesArray.enumerated() {
                                if let element = element as? NSDictionary {
                                    
                                    let discipline = Discipline(json: element as! [String : Any] )
                                    self.json.append(discipline!)
                                }
                            }
                        }
                    }
                } catch let error as NSError {
                    print("Error: \(error)")
                }
            } catch let error as NSError {
                print("Error: \(error)")
            }
        }
    }
    
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
    
}

