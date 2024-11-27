//
//  Favourites Screen.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 06/09/2024.
//

import SwiftUI

struct Favourites_Screen: View {
    @ObservedObject var favouritesManager = FavouritesManager.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favouritesManager.favourites, id: \.self) { symbol in
                    NavigationLink(destination: CryptoDetailView(symbol: symbol)) {
                        Text(symbol)
                    }
                }
            }
            .navigationTitle("Favourites")
        }
    }
}

#Preview {
    Favourites_Screen()
}
