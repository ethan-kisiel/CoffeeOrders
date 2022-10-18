//
//  HelloCoffeeEnd2EndTests.swift
//  HelloCoffeeEnd2EndTests
//
//  Created by Ethan Kisiel on 10/6/22.
//

import XCTest
final class when_deleting_an_order: XCTestCase
{
    private var app: XCUIApplication!
    
    override func setUp()
    {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "DEV"]
        app.launch()
        
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Tester")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("4.50")
        
        placeOrderButton.tap()
    }
    
    func test_should_delete_order()
    {
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        let element = cellsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft()
        collectionViewsQuery.buttons["Delete"].tap()
        
        let orderList = app.collectionViews["orderList"]
        XCTAssertEqual(0, orderList.cells.count)
    }
    
    override func tearDown()
    {
        Task
        {
            guard let url = URL(string: "/clear-orders",
                                relativeTo: URL(string: "http://192.168.33.14:5000")!)
            else { return }
            
            let (_,_) = try! await URLSession.shared.data(from: url)
        }
    }
}
final class when_addiong_a_new_coffee_order: XCTestCase
{
    private var app: XCUIApplication!
    // called prior to each test
    override func setUp()
    {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "DEV"]
        app.launch()
        
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Tester")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("4.50")
        
        placeOrderButton.tap()
    }
    
    func test_displays_coffee_order_successfully() throws
    {
        XCTAssertEqual("Tester", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Hot Coffee (Medium)", app.staticTexts["coffeeNameAndSizeText"].label)
        XCTAssertEqual("$4.50", app.staticTexts["coffeePriceText"].label)
    }
    
    // called after running each test
    override func tearDown()
    {
        Task
        {
            guard let url = URL(string: "/clear-orders",
                                relativeTo: URL(string: "http://192.168.33.14:5000")!)
            else { return }
            
            let (_,_) = try! await URLSession.shared.data(from: url)
        }
    }
}

final class app_launched_with_no_orders: XCTestCase {

    func test_should_show_no_orders_message_is_displayed() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        XCTAssertEqual("No orders available!", app.staticTexts["noOrdersText"].label)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
