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
        guard !query.isEmpty  else {
            filteredCryptos = allCryptos
            return
        }
        
        let lowercasedQuery = query.lowercased()
        
        filteredCryptos = allCryptos.filter { crypto in
            crypto.name.lowercased().contains(lowercasedQuery) ||
            crypto.symbol.lowercased().contains(lowercasedQuery)
        }
        .sorted { crypto1, crypto2 in
            let name1 = crypto1.name.lowercased()
            let name2 = crypto2.name.lowercased()
            
            let symbol1 = crypto1.symbol.lowercased()
            let symbol2 = crypto2.symbol.lowercased()
            
            let nameMatch1 = name1.contains(lowercasedQuery) ? name1.range(of: lowercasedQuery)?.lowerBound.utf16Offset(in: name1) ?? Int.max : Int.max
            let nameMatch2 = name2.contains(lowercasedQuery) ? name2.range(of: lowercasedQuery)?.lowerBound.utf16Offset(in: name2) ?? Int.max : Int.max
            
            let symbolMatch1 = symbol1.contains(lowercasedQuery) ? symbol1.range(of: lowercasedQuery)?.lowerBound.utf16Offset(in: symbol1) ?? Int.max : Int.max
            let symbolMatch2 = symbol2.contains(lowercasedQuery) ? symbol2.range(of: lowercasedQuery)?.lowerBound.utf16Offset(in: symbol2) ?? Int.max : Int.max
            
            return min(nameMatch1, symbolMatch1) < min(nameMatch2, symbolMatch2)
        }
    }
}
