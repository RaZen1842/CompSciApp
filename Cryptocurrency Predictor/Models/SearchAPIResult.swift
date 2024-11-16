//
//  SearchAPIResult.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 16/11/2024.
//

import Foundation

struct SearchedCrypto: Identifiable, Codable {
    var id: UUID { UUID() }
    let symbol: String
    let name: String
    let currency: String
}
