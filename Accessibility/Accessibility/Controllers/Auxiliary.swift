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
    case blue
    case yellow
    case black
    case green
    case red
    case colorful
}

struct UserDefaultsStruct {
    
    private static let defaults = UserDefaults.standard
    
    enum CornerMode {
        private static let defaultMode = UserCornerImage.colorful
        
        static var color: UserCornerImage {
            get {
                guard let rawValue = defaults.string(forKey: "CornerMode") else {
                    return defaultMode
                }
                
                return UserCornerImage(rawValue: rawValue) ?? defaultMode
            }
            set {
                defaults.set(newValue, forKey: "CornerMode")
            }
        }
    }
    
}
