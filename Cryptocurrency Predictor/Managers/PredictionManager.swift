//
//  PredictionManager.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 07/12/2024.
//

import Foundation

class PredictionManager: ObservableObject {
    @Published var predictedPrices: [Double] = []
    private let predictionEndpoint = "http://127.0.0.1:8000/predict"
    
    func getPredictions(for symbol: String, completion: @escaping (Bool) -> Void) {
        HistoricalFinancialDataAPI.shared.getAllCryptoHistoricalData(symbol: symbol) { success in
            guard success else {
                print("Failed to get historical data")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            let historicalData = HistoricalFinancialDataAPI.shared.allData
            
            let payload: [String: Any] = [
                "symbol": symbol,
                "historical": historicalData.map { data in
                    [
                        "date": data.date,
                        "open": data.open,
                        "high": data.high,
                        "low": data.low,
                        "close": data.close,
                        "adjClose": data.adjClose,
                        "volume": data.volume,
                        "unadjustedVolume": data.unadjustedVolume,
                        "change": data.change,
                        "changePercent": data.changePercent,
                        "vwap": data.vwap,
                        "label": data.label,
                        "changeOverTime": data.changeOverTime
                    ]
                }
            ]
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: payload) else {
                print("Failed to serialize JSON")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            guard let url = URL(string: self.predictionEndpoint) else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Request error: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [Double]], let predictions = json["predicted_prices"] {
                    DispatchQueue.main.async {
                        self.predictedPrices = predictions
                        completion(true)
                    }
                } else {
                    print("Failed to parse prediction response")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }.resume()
        }
    }
}
