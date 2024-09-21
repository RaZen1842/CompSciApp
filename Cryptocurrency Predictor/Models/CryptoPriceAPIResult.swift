//
//  CryptoPriceAPIResult.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 12/09/2024.
//

import Foundation

struct CryptoInfo: Codable {
    let data: [Crypto]
}

struct Crypto: Codable, Identifiable {
    var id: UUID { UUID() }
    let name: String
    let symbol: String
    let country: String
    var type: String
}
