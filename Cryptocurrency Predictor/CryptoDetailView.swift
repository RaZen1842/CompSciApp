//
//  CryptoDetailView.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 01/10/2024.
//

import SwiftUI

struct CryptoDetailView: View {
    let symbol: String
    @ObservedObject var financialApiManager = FinancialDataAPI.shared
    @ObservedObject var historicalApiManager = HistoricalFinancialDataAPI.shared
    
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            if let crypto = financialApiManager.cryptoFinancialData {
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
                } else if let crypto = financialApiManager.cryptoFinancialData {
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
                    financialApiManager.getFinancialData(symbol: adjustedSymbol) { success in
                        DispatchQueue.main.async {
                            isLoading = false
                        }
                    }
                }
            }
            .navigationTitle(symbol)
            
            Section {
                if !historicalApiManager.allData.isEmpty {
                    CryptoChartView(cryptoHistoricalData: historicalApiManager.allData)
                        .frame(height: 300)
                } else {
                    Text("No historical data available")
                }
            }
        }
    }
}


#Preview {
    CryptoDetailView(symbol: "BTCUSD")
}
