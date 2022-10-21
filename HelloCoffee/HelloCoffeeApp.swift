//
//  HelloCoffeeApp.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/3/22.
//

import SwiftUI

enum Route: Hashable
{
    case orders
    case addOrder
    case order(orderId: Int)
    case updateOrder(order: Order)
}

@main
struct HelloCoffeeApp: App {
    @StateObject private var model: CoffeeModel
    
    init()
    {
        var config = Configuration()
        let webservice = Webservice(baseURL: config.environment.baseURL)
        _model = StateObject(wrappedValue: CoffeeModel(webservice: webservice))
    }
    var body: some Scene {
        WindowGroup
        {
            NavigationStack
            {
                ContentView().environmentObject(model)
                    .navigationDestination(for: Route.self)
                { route in
                    switch route
                    {
                        case .orders:
                            ContentView()
                                .environmentObject(model)
                        case .addOrder:
                            AddCoffeeView()
                                .environmentObject(model)
                        case .order(let orderId):
                            OrderDetailView(orderId: orderId)
                                .environmentObject(model)
                        case .updateOrder(let order):
                            AddCoffeeView(order: order)
                                .environmentObject(model)
                    }
                }
            }
        }
    }
}
