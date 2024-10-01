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
    
    func getFinancialData(symbol: String) {
        let apiToken = "UxsKn3yimlJ98bFs00nVDZx7WyVzQpGE"
        let urlString = "https://financialmodelingprep.com/api/v3/quote/\(symbol)?apikey=\(apiToken)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode([CryptoFinancialData].self, from: data)
                    DispatchQueue.main.async {
                        self.cryptoFinancialData = response.first
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
