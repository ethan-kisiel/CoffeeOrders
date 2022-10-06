//
//  Webservice.swift
//  HelloCoffee
//
//  Created by Ethan Kisiel on 10/3/22.
//

import Foundation
enum NetworkError: Error
{
    case badRequest
    case decodingError
    case badUrl
}
@MainActor
class Webservice
{
    private var baseURL: URL
    
    init(baseURL: URL)
    {
        self.baseURL = baseURL
    }
    
    func getOrders() async throws -> [Order]
    {
        // https://island-bramble.glitch.me/test/orders
        // http://192.168.33.14:5000/orders
   
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL)
        else
        {
            throw NetworkError.badUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else
        {
            throw NetworkError.badRequest
        }
        
        guard let orders = try? JSONDecoder().decode([Order].self, from: data)
        else
        {
            print(data.lazy)
            throw NetworkError.decodingError
        }
        
        return orders
    }
}
