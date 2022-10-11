//
//  AppEnvironment.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/6/22.
//

import Foundation
enum Endpoints
{
    case allOrders
    case placeOrder
    
    var path: String
    {
        switch self
        {
            case .allOrders:
                return "/orders"
            case .placeOrder:
                return "/place-order"
        }
    }
}
struct Configuration
{
    lazy var environment: AppEnvironment =
    {
        // read val from environment vars
        guard let env = ProcessInfo.processInfo.environment["ENV"] else
        {
            return AppEnvironment.dev
        }
        if env == "TEST"
        {
            return AppEnvironment.test
        }
        
        return AppEnvironment.dev
    }()
}
enum AppEnvironment: String
{
    case dev
    case test
    
    var baseURL: URL
    {
        switch self
        {
            case .dev:
                return URL(string: "http://192.168.33.14:5000")!
            case .test:
                return URL(string: "https://island-bramble.glitch.me/test")!
        }
    }
}
