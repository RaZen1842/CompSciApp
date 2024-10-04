//
//  CryptoHistoricalData.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 04/10/2024.
//

import Foundation

struct AllCryptoHistoricalData: Codable {
    let data: [CryptoHistoricalData]
}

struct CryptoHistoricalData: Codable, Identifiable {
    var id: UUID { UUID() }
    let date: String
    let change: Double
    let changePercent: Double
    let close: Double
    let label: String
}
