//
//  TimeSeriesIntraDay.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import Foundation

struct TimeSeriesIntraDay: Codable {
    let open, high, low, close: String
    let volume: String
    var dateTime: String = ""

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode
        open = try container.decode(String.self, forKey: CodingKeys.open)
        high = try container.decode(String.self, forKey: CodingKeys.high)
        low = try container.decode(String.self, forKey: CodingKeys.low)
        close = try container.decode(String.self, forKey: CodingKeys.close)
        volume = try container.decode(String.self, forKey: CodingKeys.volume)
        
        dateTime = container.codingPath.last!.stringValue
    }
}
