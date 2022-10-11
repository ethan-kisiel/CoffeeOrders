//
//  String+Extensions.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/7/22.
//

import Foundation


extension String
{
    var notEmpty: Bool
    {
        return !self.isEmpty
    }
    
    var isNumeric: Bool
    {
        Double(self) != nil
    }
    
    func isLessThan(_ number: Double) -> Bool
    {
        if !self.isNumeric
        {
            return false
        }
        guard let value = Double(self) else { return false }
        return value < number
    }
} 
