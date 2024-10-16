//
//  Home Screen.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 06/09/2024.
//

import SwiftUI

struct Home_Screen: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home")
                    .font(.title)
                    .bold()
            }
            VStack {
                Form {
                    Section {
                        Text("Trending Currencies 📈")
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                            .bold()
                    }
                    
                    List {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    Home_Screen()
}
