//
//  MarketauxAPIManager.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 12/09/2024.
//

import Foundation

class MarketauxAPI: ObservableObject {
    static let shared = MarketauxAPI()
    private init () {}
    private let baseURL: String = "https://api.marketaux.com/v1/crypto/prices"
    private let apiToken: String = "bHraR8XR9eGBf6zK4xtq3BFDs9x0ik21MhbsTzek"
    
    func getCryptoPrice(query: String, completion: @escaping (CryptoPrice?) -> Void) {
        let query = "\(baseURL)?symbol=BTC&api_token=\(apiToken)"
        
        guard let url = URL(string: baseURL + query) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("Response JSON: \(json)")
                
                let result = try decoder.decode(CryptoPrice.self, from: data)
                completion(result)
            } catch {
                print("Error decoding JSON: \(error)")
                print("Response data: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
                completion(nil)
            }
            
        }
        task.resume()
    }
}
