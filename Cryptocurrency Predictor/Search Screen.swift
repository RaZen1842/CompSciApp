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
            }
            
            VStack {
                Form {
                    Section {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search Currency", text: $search)
                            
                            Button(action: {
                                apiManager.getCrypto(query: search)
                            }) {
                                Text("Search")
                            }
                        }
                    }
                    
                    List(apiManager.cryptos) { crypto in
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
}




#Preview {
    Search_Screen()
}
