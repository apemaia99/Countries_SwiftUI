//
//  CountriesUITests.swift
//  CountriesUITests
//
//  Created by Alessandro Di Maio on 26/09/22.
//

import XCTest

class CountriesUITests: XCTestCase {
    
    private let app = XCUIApplication()
    
    private var list: XCUIElement!
    
    override func setUp() {
        app.launch()
        continueAfterFailure = false
        
        list = app.tables["countriesList"]
    }
    
    func testListInPlaceAfterApiCall() {
        
        let exist = NSPredicate(format: "exists == 1")
        
        expectation(for: exist, evaluatedWith: list, handler: nil)
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testNavigateToFindItaly() {
        
        let target = "Italy, Europe"
        
        testListInPlaceAfterApiCall()
        
        let rowCells = list.cells.allElementsBoundByIndex
        
        guard rowCells.contains(where: { $0.label == target }) else {
            return XCTFail()
        }
    }
    
    func testAbleToExploreItaly() {
        
        let target = "Italy, Europe"
        
        testListInPlaceAfterApiCall()
        
        let rowCells = list.cells.allElementsBoundByIndex
        
        guard let cell = rowCells.first(where: { $0.label == target }) else {
            return XCTFail()
        }
        
        cell.tap()
        
        XCTAssertTrue(app.staticTexts["Italy"].exists)
        XCTAssertTrue(app.staticTexts["Italian Republic"].exists)
        XCTAssertTrue(app.staticTexts["Rome"].exists)
        XCTAssertTrue(app.staticTexts["Italian"].exists)
        XCTAssertTrue(app.staticTexts["Euro"].exists)
        XCTAssertTrue(app.staticTexts["EUR"].exists)
        XCTAssertTrue(app.staticTexts["€"].exists)
        XCTAssertTrue(app.staticTexts[".it"].exists)
        
        XCTAssertTrue(app.otherElements["Map"].exists)
    }
}
