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
    @ObservedObject var favouritesManager = FavouritesManager.shared
    @ObservedObject var predictionManager = PredictionManager.shared
    
    @State private var isLoading = true
    @State private var isHistoricalDataLoading = true
    
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
            
            Section(header: Text("Data")) {
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
            
            Section(header: Text("Chart")) {
                if  isHistoricalDataLoading {
                    Text("Loading Chart...")
                } else if !historicalApiManager.allData.isEmpty {
                    CryptoChartView(cryptoHistoricalData: historicalApiManager.allData)
                        .frame(height: 300)
                } else {
                    Text("No historical data available")
                }
            }
            .onAppear {
                if let adjustedSymbol = symbol.components(separatedBy: ":").last {
                    historicalApiManager.getAllCryptoHistoricalData(symbol: adjustedSymbol) { success in
                        DispatchQueue.main.async {
                            isHistoricalDataLoading = false
                            
                            if success {
                                predictionManager.getPredictions(for: adjustedSymbol) { predictionSuccess in
                                    if predictionSuccess {
                                        print("Prediction fetched successfully")
                                    } else {
                                        print("Failed to fetch predictions")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            //Predicted Prices
            if !predictionManager.predictedPrices.isEmpty {
                Section(header: Text("Predicted Prices")) {
                    ForEach(predictionManager.predictedPrices, id: \.self) { price in
                        Text("Predicted Prices: $\(price, specifier: "%.2f")")
                    }
                }
            } else {
                Section(header: Text("Predicted Prices")) {
                    Text("Loading predictions...")
                }
            }
            
            //Favourites type shi
            
            Section {
                Toggle(isOn: Binding(
                    get: { favouritesManager.isFavourite(symbol) },
                    set:{ isFavourite in
                        if isFavourite {
                            favouritesManager.addFavourite(symbol)
                        } else {
                            favouritesManager.removeFavourite(symbol)
                        }
                    }
                )) {
                    Text("Favourite")
                }
            }
            
            // end favs here
        }
        .alert(isPresented: $favouritesManager.showMaxFavouritesAlert) {
            Alert(
                title: Text("Maximum favourites reached"),
                message: Text("You can only have 10 favourites."),
                dismissButton: .cancel(Text("OK"),
                action: {
                    favouritesManager.showMaxFavouritesAlert = false
                })
            )
        }
    }
}


#Preview {
    CryptoDetailView(symbol: "BTCUSD")
}
