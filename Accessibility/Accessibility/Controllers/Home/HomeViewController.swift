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
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    @IBOutlet weak var calendarStackHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    @IBOutlet weak var dayLabel: UILabel!

    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.monthDay = getMonthDay()
        
        setCalendarStackHeight()
        
        let nc = NotificationCenter.default
        
        nc.addObserver(self, selector: #selector(fontChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        loadJSONFile()
        loadSportsOfTheDay(day: self.monthDay)
        printSportsOfTheDay()
        
        self.collectionViewLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        self.collectionViewLayout.minimumLineSpacing = 10
        
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
                
//                collectionView.layer.shadowColor = UIColor.black.cgColor
//                collectionView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//                collectionView.layer.shadowRadius = 2.0
//                collectionView.layer.shadowOpacity = 0.5
//                cell.contentView.layer.cornerRadius = 2.0
//                cell.contentView.layer.borderWidth = 1.0
//                cell.contentView.layer.borderColor = UIColor.clear.cgColor
//                cell.contentView.layer.masksToBounds = true
//                collectionView.layer.shadowPath = UIBezierPath(roundedRect: collectionView.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
                           
                return cell
            }
        }
        
        return UICollectionViewCell()
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

