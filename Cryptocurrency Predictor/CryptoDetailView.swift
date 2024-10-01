//
//  CryptoDetailView.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 01/10/2024.
//

import SwiftUI

struct CryptoDetailView: View {
    let symbol: String
    @ObservedObject var apiManager = FinancialDataAPI.shared
    
    var body: some View {
        VStack {
            if let crypto = apiManager.cryptoFinancialData {
                Text("Name: \(crypto.label)")
                Text("Symbol: \(crypto.symbol)")
                Text("Price: $\(crypto.price, specifier: "%.2f")")
                Text("Change: \(crypto.changesPercentage, specifier: "%.2f")")
            } else {
                Text("Loading for \(symbol)...")
            }
        }
        .onAppear {
            if let adjustedSymbol = symbol.components(separatedBy: ":").last {
                apiManager.getFinancialData(symbol: adjustedSymbol)
            }
        }
        .navigationTitle(symbol)
    }
}

#Preview {
    CryptoDetailView(symbol: "BTCUSD")
}
