//
//  View+Extensions.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/7/22.
//

import Foundation
import SwiftUI

extension View
{
    func centerHorizontally() -> some View
    {
        HStack
        {
            Spacer()
            self
            Spacer()
        }
    }
    
    @ViewBuilder
    func visible(_ expression: Bool) -> some View
    {
        switch expression
        {
            case true:
                self
            case false:
                EmptyView()
        }
    }
}
