//
//  Order.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/3/22.
//

import Foundation
enum CoffeeOrderError: Error
{
    case invalidOrderId
}
enum CoffeeSize: String, Codable, CaseIterable
{
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Order: Codable, Identifiable, Hashable
{
    var id: Int?
    var name: String
    var coffeeName: String
    var total: Double
    var coffeeSize: CoffeeSize
}
