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
                    Text("Top Stories")
                        .font(.headline)
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    if isLoading {
                        Section {
                            ProgressView("Loading News")
                                .frame(width: 300)
                        }
                    } else if isThereError {
                        Section {
                            Text("Error fetching news")
                                .frame(width: 300)
                        }
                    } else {
                        Section {
                            
                            List(newsApi.articles) { article in
                                NavigationLink(destination: NewsDetailView(article: article)) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        
                                        AsyncImage(url: URL(string: article.image_url)) { phase in
                                            
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(maxWidth: .infinity, minHeight: 200)
                                                    .cornerRadius(8)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(maxWidth: .infinity, minHeight: 200)
                                                    .clipped()
                                                    .cornerRadius(8)
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(maxWidth: .infinity, minHeight: 200)
                                                    .foregroundColor(.gray)
                                                    .cornerRadius(8)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        
                                        Text(article.title)
                                            .font(.headline)
                                        Text(article.source)
                                            .font(.caption)
                                        Text(article.description)
                                            .font(.subheadline)
                                    }
                                }
                                .padding(.vertical, 8)
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
