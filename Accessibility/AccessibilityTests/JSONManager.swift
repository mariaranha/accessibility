//
//  JSONManager.swift
//  Accessibility
//
//  Created by Matheus Oliveira on 03/02/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import Foundation

class JSONManager {
    
    private var sports: [String] = []
    
    public func loadJSONFile() -> [Discipline] {
        // Loading JSON file and building and building JSON array.
        
        let jsonFile = getJSONFile()
        var json: [Discipline] = []
        if let url = Bundle.main.url(forResource: jsonFile, withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url, options: .mappedIfSafe)
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: jsonData,
                                        options: JSONSerialization.ReadingOptions(rawValue: 0)) as? NSDictionary {
                        if let disciplinesArray = jsonResult.value(forKey: "discipline") as? NSArray {
                            for (_, element) in disciplinesArray.enumerated() {
                                if let element = element as? NSDictionary {
                                    
                                    let discipline = Discipline(json: element as! [String : Any] )
                                    json.append(discipline!)
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
        return json
    }
    
    public func getSportsForDisplay() -> [String] {
        // This function returns all sports at the
        // olympic games as a sorted string array.
        
        let json = loadJSONFile()
        for element in json {
            sports.append(element.sport)
        }
        sports = Array(Set(self.sports)).sorted()
        
        return sports
    }
    
    public func getSportNamed(sport: String) -> [Discipline] {
        // This function return all sports at the
        // olympic games as a discipline array
        
        let jsonFile = self.loadJSONFile()
        var sportsArray: [Discipline] = []
        for element in jsonFile {
            if (element.sport == sport) {
                sportsArray.append(element)
            }
        }
        
        return sportsArray
    }
    
    public func getSubcategories(sport: String ) -> [Discipline] {
        // Returns a array of subcategories based on the
        // given sport parameter
        
        var subcategories: [Discipline] = []
        
        let json = loadJSONFile()
        
        for element in json {
            if (element.sport == sport) {
                subcategories.append(element)
            }
        }
        
        return subcategories
    }
    
    // MARK: - Localization
    
    private func getJSONFile() -> String {
        if let locale = NSLocale.current.languageCode {
            switch locale {
            case "pt":
                return "calendar-pt"
            case "en":
                return "calendar-en"
            default:
                return "calendar-en"
            }
        }
        return "calendar-en"
    }
}
