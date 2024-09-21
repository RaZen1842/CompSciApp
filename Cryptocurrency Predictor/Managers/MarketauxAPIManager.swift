//
//  MarketauxAPIManager.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 12/09/2024.
//

import Foundation

class MarketauxAPI: ObservableObject {
    static let shared = MarketauxAPI()
    private let baseURL: String = "https://api.marketaux.com/v1/entity/search"
    private let apiToken: String = "bHraR8XR9eGBf6zK4xtq3BFDs9x0ik21MhbsTzek"
    
    @Published var cryptos: [Crypto] = []
    
    func getCrypto(query: String) {
        
        guard !query.isEmpty else { return }
        
        let urlString = "\(baseURL)?search=\(query)&api_token=\(apiToken)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CryptoInfo.self, from: data)
                DispatchQueue.main.async {
                    self.cryptos = result.data.filter { $0.type == "cryptocurrency" }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
            
        }.resume()
    }
}
