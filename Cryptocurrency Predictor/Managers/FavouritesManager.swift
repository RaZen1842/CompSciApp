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
    
    private init() {
        if let savedFavourites = UserDefaults.standard.array(forKey: favouritesKey) as? [String] {
            favourites = savedFavourites
        }
    }
    
    func addFavourite(_ symbol: String) {
        if !favourites.contains(symbol) {
            favourites.append(symbol)
            saveFavourites()
        }
    }
    
    func removeFavourite(_ symbol: String) {
        if let index = favourites.firstIndex(of: symbol) {
            favourites.remove(at: index)
            saveFavourites()
        }
    }
    
    func isFavourite(_ symbol: String) -> Bool {
        favourites.contains(symbol)
    }
    
    private func saveFavourites() {
        UserDefaults.standard.set(favourites, forKey: favouritesKey)
    }
}
