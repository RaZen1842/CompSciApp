//
//  ContentView.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 06/09/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAlert = false
    
    var body: some View {
            TabView {
                Home_Screen()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                Search_Screen()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                Favourites_Screen()
                    .tabItem {
                        Label("Favourites",systemImage: "star")
                    }
                News_Screen()
                    .tabItem {
                        Label("News", systemImage: "newspaper")
                    }
            }
        
        .onAppear {
            self.showAlert = true
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Disclaimer"),
                message: Text("This app is for informational purposes only. Do not use it to make financial decisions. Creators and developers of this app are not liable for any financial losses incurred."),
                dismissButton: .default(Text("I Understand"))
            )
        }
    }
}

#Preview {
    ContentView()
}
