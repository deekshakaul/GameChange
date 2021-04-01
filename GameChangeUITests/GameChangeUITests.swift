//
//  GameChangeUITests.swift
//  GameChangeUITests
//
//  Created by Deeksha Kaul on 01/04/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import Foundation
import XCTest
import Realm
import RealmSwift

class GameChangeUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = String(Date().hashValue)
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        XCUIApplication().terminate()
    }

    func testApp() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        XCUIDevice.shared.orientation = .landscapeLeft
        let tableViewQuery = app.tables.element(boundBy: 0)
        
        tableViewQuery.cells.element(boundBy: 0).tap()
        let alertButton = app.alerts.buttons.firstMatch
        if alertButton.exists {
            alertButton.tap()
        }
        tableViewQuery.cells.element(boundBy: 0).tap()
        XCUIDevice.shared.orientation = .portrait
    }
}
