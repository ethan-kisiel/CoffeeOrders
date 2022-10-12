//
//  OrderCellView.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/3/22.
//
import Foundation
import SwiftUI

struct OrderCellView: View {
    let order: Order
    var body: some View {
        HStack
        {
            VStack(alignment: .leading)
            {
                Text(order.name)
                    .accessibilityIdentifier("orderNameText")
                    .fontWeight(.bold)
                
                Text("\(order.coffeeName) (\(order.coffeeSize.rawValue))")
                    .accessibilityIdentifier("coffeeNameAndSizeText")
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("coffeePriceText")
        }
    }
}
