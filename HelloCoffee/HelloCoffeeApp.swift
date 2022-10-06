//
//  HelloCoffeeApp.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/3/22.
//

import SwiftUI

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
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
