//
//  Search Screen.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 06/09/2024.
//

import SwiftUI

struct Search_Screen: View {
    
    @State private var search: String = ""
    @State private var isLoading = true
    
    @ObservedObject private var apiManager = SearchCurrenciesAPI.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search Currency", text: $search)
                                .onChange(of: search) { oldValue, newValue in
                                    if newValue != "" {
                                        apiManager.searchCryptos(query: newValue)
                                    }
                                }
                        }
                    }
                    
                    List(apiManager.filteredCryptos) { crypto in
                        NavigationLink(destination: CryptoDetailView(symbol: crypto.symbol)) {
                            VStack(alignment: .leading) {
                                Text(crypto.name)
                                    .bold()
                                Text(crypto.symbol)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search Crypto")
            .onAppear {
                apiManager.getAllCryptos { success in
                    isLoading = !success
                }
            }
        }
    }
}




#Preview {
    Search_Screen()
}
