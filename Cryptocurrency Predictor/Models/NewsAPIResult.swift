//
//  NewsAPIResult.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 18/11/2024.
//

import Foundation

struct NewsAPIResult: Codable {
    let data: [Article]
}

struct Article: Codable, Identifiable {
    var id: UUID { UUID() }
    let uuid: String
    let title: String
    let description: String
    let snippet: String
    let url: String
    let image_url: String
    let published_at: String
    let source: String
}
