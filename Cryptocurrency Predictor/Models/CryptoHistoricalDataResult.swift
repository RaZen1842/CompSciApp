//
//  CryptoHistoricalData.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 04/10/2024.
//

import Foundation

struct AllCryptoHistoricalData: Codable {
    let historical: [CryptoHistoricalData]
}

struct CryptoHistoricalData: Codable, Identifiable {
    var id: UUID { UUID() }
    let date: String
    let change: Double
    let changePercent: Double
    let close: Double
    let label: String
    let open: Double
    let high: Double
    let low: Double
    let volume: Double
    let adjClose: Double
    let unadjustedVolume: Double
    let vwap: Double
    let changeOverTime: Double
    
    var newDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)
    }
}
