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
            VStack {
                if favouritesManager.favourites.isEmpty {
                    Text("No favourites yet")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(favouritesManager.favourites, id: \.self) { symbol in
                        HStack {
                            if let crypto = favouritesManager.favouritesDetails[symbol] {
                                NavigationLink(destination: CryptoDetailView(symbol: symbol)) {
                                    VStack(alignment: .leading) {
                                        Text(crypto.name)
                                            .font(.headline)
                                        Text(crypto.symbol)
                                            .font(.subheadline)
                                    }
                                }
                            } else {
                                NavigationLink(destination: CryptoDetailView(symbol: symbol)) {
                                    Text(symbol)
                                        .font(.headline)
                                    Text("Details Loading...")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
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
