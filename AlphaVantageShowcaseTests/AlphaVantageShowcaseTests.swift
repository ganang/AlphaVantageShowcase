//
//  AlphaVantageShowcaseTests.swift
//  AlphaVantageShowcaseTests
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import XCTest
@testable import AlphaVantageShowcase

class AlphaVantageShowcaseTests: XCTestCase {

    // Test Case 1 : Test fetching stock success,
    // only test for intraday because the rest of endpoint is have same format
    func testFetchStockSuccess() {
        let stockProvider = StockProvider.shared
        let stockExpectaion = expectation(description: "Intraday")
        var intraDayResponse: IntraDayResponse?
        let params = ["function": "TIME_SERIES_INTRADAY", "symbol": "IBM", "interval": "15min", "outputsize": "compact"]
        
        stockProvider.getIntraDayStock(endpoint: .stock, params: params) { (response) in
            intraDayResponse = response
            stockExpectaion.fulfill()
        } onError: { (_) in
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNotNil(intraDayResponse)
        }
    }
    
    // Test Case 2 : Test fetching stock error,
    // only test for intraday because the rest of endpoint is have same format
    func testFetchStockError() {
        let stockProvider = StockProvider.shared
        let errorExpectation = expectation(description: "Error")
        var errorResponse: Error?
        let params = ["function": "TIME_SERIES_INTRADAY", "symbol": "XXXXXXXXX", "interval": "15min", "outputsize": "compact"]
        
        stockProvider.getIntraDayStock(endpoint: .stock, params: params) { (_) in
        } onError: { (error) in
            errorExpectation.fulfill()
            errorResponse = error
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }
    
    // Test Case 3 : Set Api Key
    func testApiKey() {
        
        LocalStorageService.shared.setApikey(withApiKey: "61F1SVWHXJH7NI2E", withKey: "apikey")
        
        XCTAssertEqual(LocalStorageService.shared.getApikey(), "61F1SVWHXJH7NI2E")
    }
    
    // Test Case 4 : Set Interval
    func testInterval() {
        
        LocalStorageService.shared.setInterval(interval: "15min")
        
        XCTAssertEqual(LocalStorageService.shared.getInterval(), "15min")
    }
    
    // Test Case 5 : Set OutputSize
    func testOutputSize() {
        
        LocalStorageService.shared.setOutputSize(outputsize: "compact")
        
        XCTAssertEqual(LocalStorageService.shared.getOutputSize(), "compact")
    }
    
}
