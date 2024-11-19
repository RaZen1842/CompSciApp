//
//  News Screen.swift
//  Cryptocurrency Predictor
//
//  Created by Veturi, Shreyas (HJRM) on 06/09/2024.
//

import SwiftUI

struct News_Screen: View {
    @ObservedObject private var newsApi = NewsAPI.shared
    
    @State private var isLoading: Bool = false
    @State private var isThereError: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("News")
                    .font(.title)
                    .bold()
            }
            VStack {
                Form {
                    if isLoading {
                        Section {
                            ProgressView("Loading News")
                        }
                    } else if isThereError {
                        Section {
                            Text("Error fetching news")
                        }
                    } else {
                        Section {
                            List(newsApi.articles) { article in
                                VStack(alignment: .leading) {
                                    Text(article.title)
                                        .font(.headline)
                                        .lineLimit(2)
                                    Text(article.description)
                                        .font(.subheadline)
                                        .lineLimit(10)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                isLoading = true
                isThereError = false
                newsApi.getNews { success in
                    isLoading = false
                    if !success {
                        isThereError = true
                    }
                }
            }
        }
    }
}

#Preview {
    News_Screen()
}
