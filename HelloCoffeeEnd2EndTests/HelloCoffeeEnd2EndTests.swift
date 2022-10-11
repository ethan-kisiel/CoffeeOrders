//
//  HelloCoffeeEnd2EndTests.swift
//  HelloCoffeeEnd2EndTests
//
//  Created by Ethan Kisiel on 10/6/22.
//

import XCTest

final class app_launched_with_no_orders: XCTestCase {

    func test_should_show_no_orders_message_is_displayed() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "DEV"]
        app.launch()
        
        XCTAssertEqual("No orders available!", app.staticTexts["noOrdersText"].label)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
