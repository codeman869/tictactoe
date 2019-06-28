//
//  tictactoeUITests.swift
//  tictactoeUITests
//
//  Created by Cody Deckard on 3/30/19.
//  Copyright © 2019 Cody Deckard. All rights reserved.
//

import XCTest

class tictactoeUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPressPlay() {
        let button = XCUIApplication().otherElements.containing(.image, identifier:"board").children(matching: .button).element(boundBy: 0)
        let beforeButton = button.screenshot()
        button.tap()
        let afterButton = button.screenshot()
        
        XCTAssertNotEqual(beforeButton, afterButton)
        
    }
    
    func testFirstPlayButtonDisabled() {
        
        let app = XCUIApplication()
        app.otherElements.containing(.image, identifier:"board").children(matching: .button).element(boundBy: 0).tap()
        
        XCTAssertFalse(app.buttons["X Plays First"].isEnabled)
        
        
    }
    
    func testWinShowsAlert() {
        
        let app = XCUIApplication()
        let boardElementsQuery = app.otherElements.containing(.image, identifier:"board")
        boardElementsQuery.children(matching: .button).element(boundBy: 0).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 1).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 4).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 3).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 8).tap()
        
        XCTAssertTrue(app.alerts["X has won!"].exists)
 
    }
    
    func testCatsGameShowsAlert() {
        
        let app = XCUIApplication()
        let boardElementsQuery = app.otherElements.containing(.image, identifier:"board")
        boardElementsQuery.children(matching: .button).element(boundBy: 0).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 4).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 6).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 3).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 5).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 2).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 8).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 7).tap()
        boardElementsQuery.children(matching: .button).element(boundBy: 1).tap()
        
        XCTAssertTrue(app.alerts["Cats game!"].exists)
    }

}
