//
//  TrendingCurrenciesAPI.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 16/10/2024.
//

import Foundation
import Combine

class TrendingCurrenciesAPI: ObservableObject {
    static let shared = TrendingCurrenciesAPI()
    
    @Published var trendingCryptos: [TrendingCrypto] = []
    
    private let baseURL: String = "https://financialmodelingprep.com/api/v3/quotes/crypto"
    private let apiKey: String = "UxsKn3yimlJ98bFs00nVDZx7WyVzQpGE"
    
    func getTop5TrendingCryptos(completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)?apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        
        //remember you may have to add the [weak self] or smt below
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AllTrendingCryptos.self, from: data)
                DispatchQueue.main.async {
                    //may have to add a '?' after self
                    self.trendingCryptos = result.cryptos
                        .sorted { $0.changePercent > $1.changePercent }
                        .prefix(5)
                        .map { $0 }
                    completion(true)
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }.resume()
    }
}
