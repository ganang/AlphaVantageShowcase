//
//  DailyResponse.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import Foundation

struct DailyResponse: Codable {
    var metadata: DailyMetadata?
    var dailyTimeseries: [String: DailyTimeseries]?

    private struct CustomCodingKeys: CodingKey {
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKeys.self)
        
        for key in container.allKeys {
            if key.stringValue == "Meta Data" {
                self.metadata = try container.decode(DailyMetadata.self, forKey: key)
                
                continue
            }
            
            self.dailyTimeseries = try container.decode([String: DailyTimeseries].self, forKey: key)
            
        }
    }
}

public struct DailyMetadata: Codable {
    let information: String
    let symbol: String
    let lastRefresh: String
    let outputSize: String
    let timezone: String
    
    private enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefresh = "3. Last Refreshed"
        case outputSize = "4. Output Size"
        case timezone = "5. Time Zone"
    }
}

struct DailyTimeseries: Codable {
    let open, high, low, close: String
    let volume, adjustedClose, dividedAmount: String
    let splitCoefficient: String
    var dateTime: String = ""

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case adjustedClose = "5. adjusted close"
        case volume = "6. volume"
        case dividedAmount = "7. dividend amount"
        case splitCoefficient = "8. split coefficient"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode
        open = try container.decode(String.self, forKey: CodingKeys.open)
        high = try container.decode(String.self, forKey: CodingKeys.high)
        low = try container.decode(String.self, forKey: CodingKeys.low)
        close = try container.decode(String.self, forKey: CodingKeys.close)
        volume = try container.decode(String.self, forKey: CodingKeys.volume)
        adjustedClose = try container.decode(String.self, forKey: CodingKeys.adjustedClose)
        dividedAmount = try container.decode(String.self, forKey: CodingKeys.dividedAmount)
        splitCoefficient = try container.decode(String.self, forKey: CodingKeys.splitCoefficient)
        
        dateTime = container.codingPath.last!.stringValue
    }
}

