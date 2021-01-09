//
//  IntraDayResponse.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import Foundation

public struct IntraDayResponse: Codable {
    var metadata: Metadata?
    var timeSeriesIntraDay: [String: TimeSeriesIntraDay]?

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
                self.metadata = try container.decode(Metadata.self, forKey: key)
                
                continue
            }
            
            self.timeSeriesIntraDay = try container.decode([String: TimeSeriesIntraDay].self, forKey: key)
            
        }
    }
    
}

public struct Metadata: Codable {
    let information: String
    let symbol: String
    let lastRefresh: String
    let interval: String
    let outputSize: String
    let timezone: String
    
    private enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefresh = "3. Last Refreshed"
        case interval = "4. Interval"
        case outputSize = "5. Output Size"
        case timezone = "6. Time Zone"
    }
}
