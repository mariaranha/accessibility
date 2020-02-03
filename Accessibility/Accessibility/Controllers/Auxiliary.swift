//
//  Auxiliary.swift
//  Accessibility
//
//  Created by Julia Conti Mestre on 31/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import Foundation
import UIKit

enum UserCornerImage: String {
    case blue = "blue"
    case yellow = "yellow"
    case black = "black"
    case green = "green"
    case red = "red"
    case colorfull = "colorful"
}

struct Country {
    var code = String()
    var flag = UIImage()
}

struct UserDefaultsStruct {
    
    private static let defaults = UserDefaults.standard
    
    //Default
    struct DefaultCorner {
        static let color = UserCornerImage.colorfull.rawValue
    }
    
    struct CornerMode {
        static var color: String {
            get {
                return defaults.string(forKey: "CornerMode") ?? DefaultCorner.color
            }
            set {
                defaults.set(newValue, forKey: "CornerMode")
            }
        }
    }
    
}
