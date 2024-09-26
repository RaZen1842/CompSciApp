//
//  FinancialDataAPIResult.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 26/09/2024.
//

import Foundation

struct AllCrpytoFinancialData: Codable {
    let data: [CryptoFinancialData]
}

struct CryptoFinancialData: Codable, Identifiable {
    var id: UUID { UUID() }
    let symbol: String
    let date: String
    let label: String
    let change: Double
    let changePercent: Double
    let high: Double
    let open: Double
    let low: Double
    let close: Double
}
