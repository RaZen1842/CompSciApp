//
//  TrendingCurrenciesAPI.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 16/10/2024.
//

import Foundation

class DiscoverCurrenciesAPI: ObservableObject {
    static let shared = DiscoverCurrenciesAPI()
    
    @Published var discoveredCryptos: [DiscoveredCrypto] = []
    
    private let baseURL: String = "https://financialmodelingprep.com/api/v3/symbol/available-cryptocurrencies"
    private let apiKey: String = "UxsKn3yimlJ98bFs00nVDZx7WyVzQpGE"
    
    //Screenshot
    private let userDefaultsKey = "SavedCryptos"
    private let dateKey = "SavedCryptosDate"
    //Screenshot
    
    func getTop5TrendingCryptos(completion: @escaping (Bool) -> Void) {
        //Screenshot
        
        if let savedDate = UserDefaults.standard.object(forKey: dateKey) as? Date,
           Calendar.current.isDateInToday(savedDate),
           let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedCryptos = try? JSONDecoder().decode([DiscoveredCrypto].self, from: savedData) {
            DispatchQueue.main.async {
                self.discoveredCryptos = savedCryptos
                completion(true)
            }
            return
        }
        
        //Screenshot
        
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
                let result = try JSONDecoder().decode([DiscoveredCrypto].self, from: data)
                DispatchQueue.main.async {
                    let usdCryptos = result.filter { $0.currency == "USD" }
                    let randomCryptos = Array(usdCryptos.shuffled().prefix(5))
                    self?.discoveredCryptos = randomCryptos
                    
                    self?.saveCryptosToUserDefaults(randomCryptos)
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
    
    private func saveCryptosToUserDefaults(_ cryptos: [DiscoveredCrypto]) {
        if let encodedData = try? JSONEncoder().encode(cryptos) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
        
        UserDefaults.standard.set(Date(), forKey: dateKey)
    }
}
