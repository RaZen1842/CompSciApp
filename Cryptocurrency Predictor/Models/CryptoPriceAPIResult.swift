//
//  CryptoPriceAPIResult.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 12/09/2024.
//

import Foundation

struct CryptoPrice: Codable {
    let symbol: String
    let price: Double
}
