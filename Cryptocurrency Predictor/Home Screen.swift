//
//  Home Screen.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 06/09/2024.
//

import SwiftUI

struct Home_Screen: View {
    
    @StateObject private var discoverCryptosAPI = DiscoverCurrenciesAPI.shared
    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home")
                    .font(.title)
                    .bold()
            }
            .onAppear {
                discoverCryptosAPI.getTop5TrendingCryptos { success in
                    isLoading = !success
                }
            }
            VStack {
                Form {
                    Section {
                        Text("💸 Discover Currencies 💸")
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .bold()
                    }
                    
                    Section {
                        Text("Discover new cryptocurrencies every day!")
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                    }
                    
                    Section {
                        List(discoverCryptosAPI.discoveredCryptos) { crypto in
                            NavigationLink(destination: CryptoDetailView(symbol: crypto.symbol)) {
                                VStack {
                                    Text(crypto.name)
                                        .bold()
                                }
                            }
                        }
                    }

                }
            }
        }
        .overlay(
            isLoading ? ProgressView("Loading...") : nil
        )
    }
}

#Preview {
    Home_Screen()
}
