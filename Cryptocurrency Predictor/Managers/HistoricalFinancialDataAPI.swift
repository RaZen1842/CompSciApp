//
//  HistoricalFinancialDataAPI.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 04/10/2024.
//

import Foundation

class HistoricalFinancialDataAPI: ObservableObject {
    static let shared = HistoricalFinancialDataAPI()
    @Published var allData: [CryptoHistoricalData] = []
    
    private let baseURL: String = "https://financialmodelingprep.com/api/v3/historical-price-full/"
    private let apiToken: String = "UxsKn3yimlJ98bFs00nVDZx7WyVzQpGE"
    
    func getAllCryptoHistoricalData(symbol: String, completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)\(symbol)?apikey=\(apiToken)"
    }
}
