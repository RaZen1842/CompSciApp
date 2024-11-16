//
//  SearchCurrenciesAPI.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 16/11/2024.
//

import Foundation

class SearchCurrenciesAPI: ObservableObject {
    static let shared = SearchCurrenciesAPI()
    
    private let baseURL: String = "https://financialmodelingprep.com/api/v3/symbol/available-cryptocurrencies"
    private let apiKey: String = "UxsKn3yimlJ98bFs00nVDZx7WyVzQpGE"
    
    @Published var allCryptos: [SearchedCrypto] = []
    @Published var filteredCryptos: [SearchedCrypto] = []
    
    func getAllCryptos(completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)?apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
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
                let cryptos = try JSONDecoder().decode([SearchedCrypto].self, from: data)
                DispatchQueue.main.async {
                    self?.allCryptos = cryptos.filter { $0.currency == "USD" }
                    self?.filteredCryptos = []
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
    
    func searchCryptos(query: String) {
        if query.isEmpty {
            filteredCryptos = allCryptos
        } else {
            filteredCryptos = allCryptos.filter {
                $0.name.localizedCaseInsensitiveContains(query) ||
                $0.symbol.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
}
