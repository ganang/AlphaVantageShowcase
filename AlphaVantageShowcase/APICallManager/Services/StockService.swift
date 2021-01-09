//
//  StockService.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import Foundation

// define available service
protocol StockService {
    
    // get daily stock
    func getDailyStock(endpoint: StockEndpoint , params: [String:String]?, onSuccess: @escaping (_ response: DailyResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
    
    // get intra-day stock
    func getIntraDayStock(endpoint: StockEndpoint , params: [String:String]?, onSuccess: @escaping (_ response: IntraDayResponse) -> Void, onError: @escaping(_ error: Error) -> Void)
}

// list of available stock endpoint
public enum StockEndpoint: String, CaseIterable, Identifiable {
    public var id: String { self.rawValue }
    
    case stock = "query"
}

// define custom error
public enum StockError: Error {
    case errorFromApi
    case noData
    case invalidEndpoint
    case invalidResponse
    case serializationError
}
