//
//  JsonTest.swift
//  AccessibilityTests
//
//  Created by Matheus Oliveira on 30/01/20.
//  Copyright © 2020 Marina Miranda Aranha. All rights reserved.
//

import Foundation
import XCTest
@testable import Accessibility

class JsonTest: XCTest {
    
    func testJson() {
        guard let url = Bundle.main.url(forResource:"calendar", withExtension: "json") else {
            XCTFail("calendar.json does not exist")
            return
        }
    }
}
