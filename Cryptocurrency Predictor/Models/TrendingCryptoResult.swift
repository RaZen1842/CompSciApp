//
//  TrendingCryptoResult.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 02/11/2024.
//

import Foundation

struct AllTrendingCryptos: Codable {
    let cryptos: [TrendingCrypto]
}

struct TrendingCrypto: Codable, Identifiable {
    var id: UUID { UUID() }
    let symbol: String
    let name: String
    let price: Double
    let changePercent: Double
}
