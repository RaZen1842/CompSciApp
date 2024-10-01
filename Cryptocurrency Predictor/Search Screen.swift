//
//  Search Screen.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 06/09/2024.
//

import SwiftUI

struct Search_Screen: View {
    
    @State private var search: String = ""
    @ObservedObject private var apiManager = MarketauxAPI.shared
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Search Crypto")
                    .font(.title)
                    .bold()
                    .padding()
            }
            .padding()
            VStack {
                
                Form {
                    TextField("Enter Crypto", text: $search)
                        .onChange(of: search) { oldValue, newValue in
                            apiManager.getCrypto(query: newValue)
                        }
                    List(apiManager.cryptos) { crypto in
                        NavigationLink(destination: CryptoDetailView(symbol: crypto.symbol)) {
                            VStack {
                                Text(crypto.name)
                                    .bold()
                                Text("Symbol: \(crypto.symbol)")
                                Text("Country: \(crypto.country)")
                                Text("Type: \(crypto.type)")
                            }
                        }
                    }
                }
            }
        }
    }
}




#Preview {
    Search_Screen()
}
