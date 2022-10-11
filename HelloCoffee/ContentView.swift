//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/3/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: CoffeeModel
    
    private func populateOrders() async
    {
        do
        {
            try await model.populateOrders()
        }
        catch
        {
            print(error)
        }
    }
    var body: some View {
        NavigationLink(value: Route.addOrder)
        {
            HStack(alignment: .top)
            {
                Spacer()
                Text("Add New Order")
                    .accessibilityIdentifier("placeOrderButton")
            }.padding(9)
        }
        VStack
        {
            if model.orders.isEmpty
            {
                Text("No orders available!")
                    .accessibilityIdentifier("noOrdersText")
            }
            List(model.orders)
            { order in
                OrderCellView(order: order)
            }
        }.task {
            await populateOrders()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        NavigationStack
        {
            ContentView()
                .environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
        }
    }
}
