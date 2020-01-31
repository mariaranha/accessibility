//
//  Discipline.swift
//  Accessibility
//
//  Created by Matheus Oliveira on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import Foundation

class Discipline {
    var name: String
    var sport: String
    var normalDates: [Int]
    var medalDates: [Int]
    var is1v1: Bool
    
    // Standart initializer
    init(name: String, sport: String, normalDates: [Int], medalDates: [Int], is1v1: Bool) {
        self.name = name
        self.sport = sport
        self.normalDates = normalDates
        self.medalDates = medalDates
        self.is1v1 = is1v1
    }
    
    // JSON initializer
    init?(json: [String: Any]) {
        
        self.name = json["name"] as? String ?? "Discipline not found"
        self.sport = json["sport"] as? String ?? "Sport not found"
        self.normalDates = json["normal"] as? [Int] ?? []
        self.medalDates = json["medal"] as? [Int] ?? []
        self.is1v1 = json["is1v1"] as? Bool ?? true
    }
}
