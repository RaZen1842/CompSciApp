//
//  FinancialDataAPIResult.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 26/09/2024.
//

import Foundation

struct CryptoFinancialData: Codable, Identifiable {
    var id: UUID { UUID() }
    let symbol: String
    let name: String
    let price: Double
    let change: Double
    let changesPercentage: Double
    let dayHigh: Double
    let dayLow: Double
}
