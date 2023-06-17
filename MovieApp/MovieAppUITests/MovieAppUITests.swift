//
//  MovieAppUITests.swift
//  MovieAppUITests
//
//  Created by Марина Рябчун on 04.06.2023.
//

import XCTest

final class MovieAppUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func test_inputCorrectNameMovie_returnSuccess() throws {

        let searchBar = app.navigationBars["Movies"].searchFields["Search Movie"]
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()

        let keyboard = app.keyboards.element
        XCTAssertTrue(keyboard.waitForExistence(timeout: 5))

        searchBar.typeText("Shrek")

        app.buttons["Search"].tap()
        
        let resultsTable = app.tables["TableMovies"]
        XCTAssertTrue(resultsTable.exists)
        sleep(3)
        XCTAssertTrue(resultsTable.cells.count > 0)
        let cell = resultsTable.cells.element(boundBy: 0)
        XCTAssertTrue(cell.exists)
    }
    
    func test_inputInCorrectNameMovie_returnSuccess() throws {
        
        let searchBar = app.navigationBars["Movies"].searchFields["Search Movie"]
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        
        let keyboard = app.keyboards.element
        XCTAssertTrue(keyboard.waitForExistence(timeout: 5))

        searchBar.typeText("арпааораморморм")
        app.buttons["Search"].tap()
        
        let resultsTable = app.tables["TableMovies"]
        XCTAssertTrue(resultsTable.exists)
        sleep(3)
        XCTAssertTrue(resultsTable.cells.count == 0)
    }
}
