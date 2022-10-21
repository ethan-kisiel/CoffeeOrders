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
    var order: Order? = nil
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    @State private var errors: AddCoffeeErrors = AddCoffeeErrors()
    
    @State private var updatingOrder: Bool = false
    
    private var placeOrUpdate: String
    {
        updatingOrder ? "Update" : "Place"
    }
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: CoffeeModel
    
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
        return errors.price.isEmpty && errors.coffeeName.isEmpty && errors.name.isEmpty
    }
    
    private func placeOrder() async
    {
        let order = Order(id: order?.id ?? 0, name: name, coffeeName: coffeeName, total: Double(price) ?? 0, coffeeSize: coffeeSize)
        
        do
        {
            if updatingOrder
            {
                try await model.updateOrder(order)
            }
            else
            {
                try await model.placeOrder(order)
            }
            dismiss()
        }
        catch
        {
            print(error)
        }
    }
    
    private func populateExistingOrder()
    {
        if let order = order
        {
            name = order.name
            coffeeName = order.coffeeName
            coffeeSize = order.coffeeSize
            price = String(order.total)
            
            updatingOrder = true
        }
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
            
            
            Button("\(placeOrUpdate) Order")
            {
                if validForm
                {
                    // place order
                    Task
                    {
                        await placeOrder()
                    }
                }
            }.accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()
            
        }.navigationTitle("\(placeOrUpdate) Order")
            .onAppear
            {
                populateExistingOrder()
            }
    }
}

struct AddCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeView()
    }
}
