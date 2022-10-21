//
//  OrderDetailView.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/20/22.
//

import SwiftUI

struct OrderDetailView: View {
    @EnvironmentObject private var model: CoffeeModel
    @Environment(\.dismiss) var dismiss
    let orderId: Int
    func deleteOrder(_ orderId: Int) async
    {
        do
        {
            try await model.deleteOrder(orderId)
            dismiss()
        }
        catch
        {
            print("Error: \(error)")
        }
    }
    var body: some View
    {
        VStack
        {
            if let order = model.orderById(orderId)
            {
                VStack(alignment: .leading, spacing: 10)
                {
                    Text(order.coffeeName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityIdentifier("coffeeNameText")
                    Text(order.coffeeSize.rawValue)
                        .opacity(0.5)
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                    
                    HStack
                    {
                        Spacer()
                        Button("Delete Order", role: .destructive)
                        {
                            if let orderId = order.id
                            {
                                Task
                                {
                                    await deleteOrder(orderId)
                                }
                            }
                        }
                        NavigationLink(value: Route.updateOrder(order: order))
                        {
                            Text("Edit Order")
                        }.accessibilityIdentifier("editOrderButton")
                        /*
                        Button("Edit Order")
                        {
                            
                        }
                        */
                        Spacer()
                    }
                }
            }
            Spacer()
        }.padding()
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        OrderDetailView(orderId: 0).environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
    }
}
