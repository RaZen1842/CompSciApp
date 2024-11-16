//
//  CryptoPriceAPIResult.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 12/09/2024.
//

//Might have to delete once I finish my search API redo
import Foundation

struct CryptoInfo: Codable {
    let data: [Crypto]
}

struct Crypto: Codable, Identifiable {
    var id: UUID { UUID() }
    let name: String
    let symbol: String
    var type: String
}

//Might delete once I finish search API redo
