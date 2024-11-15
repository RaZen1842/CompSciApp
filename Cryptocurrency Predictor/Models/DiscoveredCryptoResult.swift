//
//  TrendingCryptoResult.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 02/11/2024.
//

import Foundation

struct DiscoveredCrypto: Codable, Identifiable {
    var id: UUID { UUID() }
    let symbol: String
    let name: String
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case currency
    }
}
