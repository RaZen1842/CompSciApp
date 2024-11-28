//
//  FavouritesManager.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 27/11/2024.
//

import Foundation

class FavouritesManager: ObservableObject {
    static let shared = FavouritesManager()
    private let favouritesKey = "favouriteCryptos"
    @Published var favourites: [String] = []
    @Published var showMaxFavouritesAlert: Bool = false
    @Published var favouritesDetails: [String: CryptoFinancialData] = [:]
    
    private let maxFavourites = 10
    
    private init() {
        if let savedFavourites = UserDefaults.standard.array(forKey: favouritesKey) as? [String] {
            favourites = savedFavourites
        }
        getFavouritesDetails()
    }
    
    func addFavourite(_ symbol: String) {
        guard favourites.count < maxFavourites else {
            showMaxFavouritesAlert = true
            return
        }
        
        if !favourites.contains(symbol) {
            favourites.append(symbol)
            saveFavourites()
            getDetails(for: symbol)
        }
    }
    
    func removeFavourite(_ symbol: String) {
        if let index = favourites.firstIndex(of: symbol) {
            favourites.remove(at: index)
            favouritesDetails.removeValue(forKey: symbol)
            saveFavourites()
        }
    }
    
    func isFavourite(_ symbol: String) -> Bool {
        favourites.contains(symbol)
    }
    
    private func saveFavourites() {
        UserDefaults.standard.set(favourites, forKey: favouritesKey)
    }
    
    private func getFavouritesDetails() {
        favourites.forEach { getDetails(for: $0) }
    }
    
    private func getDetails(for symbol: String) {
        FinancialDataAPI.shared.getFinancialData(symbol: symbol) { [weak self] success in
            guard success, let data = FinancialDataAPI.shared.cryptoFinancialData else { return }
            DispatchQueue.main.async {
                self?.favouritesDetails[symbol] = data
            }
        }
    }
}
