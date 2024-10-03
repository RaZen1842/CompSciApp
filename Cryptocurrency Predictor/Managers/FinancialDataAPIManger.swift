//
//  FinancialDataAPI.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 26/09/2024.
//

import Foundation

class FinancialDataAPI: ObservableObject {
    static let shared = FinancialDataAPI()
    @Published var cryptoFinancialData: CryptoFinancialData?
    
    func getFinancialData(symbol: String, completion: @escaping (Bool) -> Void) {
        let apiToken = "UxsKn3yimlJ98bFs00nVDZx7WyVzQpGE"
        let urlString = "https://financialmodelingprep.com/api/v3/quote/\(symbol)?apikey=\(apiToken)"
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode([CryptoFinancialData].self, from: data)
                    DispatchQueue.main.async {
                        self.cryptoFinancialData = response.first
                        completion(true)
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
        }.resume()
    }
}
