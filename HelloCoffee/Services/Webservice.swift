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
    
    func placeOrder(order: Order) async throws -> Order
    {
        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseURL) else
        {
            throw NetworkError.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(order)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else
        {
            throw NetworkError.badRequest
        }
        
        guard let newOrder = try? JSONDecoder().decode(Order.self, from: data)
        else
        {
            throw NetworkError.decodingError
        }
        
        return newOrder
    }
}
