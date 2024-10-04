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
    
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            if let crypto = apiManager.cryptoFinancialData {
                Text("\(crypto.name)")
                    .font(.title)
                    .bold()
            } else {
                Text("\(symbol)")
                    .font(.title)
                    .bold()
            }
        }
        
        Form {
            
            Section {
                if isLoading {
                    Text("Looking for \(symbol)")
                } else if let crypto = apiManager.cryptoFinancialData {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name: \(crypto.name)")
                        Text("Symbol: \(crypto.symbol)")
                        Text("Price: $\(crypto.price, specifier: "%.2f")")
                        Text("Change: \(crypto.changesPercentage, specifier: "%.2f")%")
                    }
                } else {
                    Text("No data for for \(symbol)...")
                }
            }
            .onAppear {
                if let adjustedSymbol = symbol.components(separatedBy: ":").last {
                    apiManager.getFinancialData(symbol: adjustedSymbol) { success in
                        DispatchQueue.main.async {
                            isLoading = false
                        }
                    }
                }
            }
            .navigationTitle(symbol)
            
            Section {
                
            }
        }
    }
}

#Preview {
    CryptoDetailView(symbol: "BTCUSD")
}
