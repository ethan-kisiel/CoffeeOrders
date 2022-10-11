//
//  AddCoffeeView.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/7/22.
//

import SwiftUI
struct AddCoffeeErrors
{
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
}

struct AddCoffeeView: View {
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    @State private var errors: AddCoffeeErrors = AddCoffeeErrors()
    
    var validForm: Bool
    {
        errors = AddCoffeeErrors()
        
        // validate fields and set error messages
        if name.isEmpty
        {
            errors.name = "Name field is required."
        }
        
        if coffeeName.isEmpty
        {
            errors.coffeeName = "Coffee name field is required."
        }
        
        if price.isEmpty
        {
            errors.price = "Price field is required."
        }
        else if !price.isNumeric
        {
            errors.price = "Price field must be a valid number."
        }
        else if price.isLessThan(1)
        {
            errors.price = "Price field must be greater than 0."
        }
        
        // return error messages empty
        return price.isEmpty && coffeeName.isEmpty && name.isEmpty
    }
    
    var body: some View
    {
        Form
        {
            TextField("Name", text: $name)
                .accessibilityIdentifier("name")
            Text(errors.name).visible(errors.name.notEmpty)
                .foregroundColor(.red)
                .font(.caption)
            
            TextField("Coffee name", text: $coffeeName)
                .accessibilityIdentifier("coffeeName")
            Text(errors.coffeeName).visible(errors.coffeeName.notEmpty)
                .foregroundColor(.red)
                .font(.caption)
            
            TextField("Price", text: $price)
                .accessibilityIdentifier("price")
            Text(errors.price).visible(errors.price.notEmpty)
                .foregroundColor(.red)
                .font(.caption)
            
            Picker("Select size", selection: $coffeeSize)
            {
                ForEach(CoffeeSize.allCases, id: \.rawValue)
                { size in
                    Text(size.rawValue).tag(size)
                }
            }
            
            Button("Place Order")
            {
                if validForm
                {
                    // place order
                    
                }
            }.accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()
        }
    }
}

struct AddCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeView()
    }
}
