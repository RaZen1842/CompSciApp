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
            
            Group {
                if  favouritesManager.favourites.isEmpty {
                    Text("No favourites yet")
                        .font(.title2)
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(favouritesManager.favourites, id: \.self) { symbol in
                            if let crypto = favouritesManager.favouritesDetials[symbol] {
                                NavigationLink(destination: CryptoDetailView(symbol: symbol)) {
                                    VStack(alignment: .leading) {
                                        Text(crypto.name)
                                            .font(.headline)
                                        Text("\(crypto.symbol) (\(crypto.rank))")
                                            .font(.subheadline)
                                    }
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
