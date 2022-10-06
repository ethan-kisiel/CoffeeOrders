//
//  NumberFormatter+Extensions.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/5/22.
//

import Foundation

extension NumberFormatter
{
    static var currency: NumberFormatter
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
