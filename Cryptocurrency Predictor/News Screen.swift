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
                                    HStack(alignment: .top, spacing: 12) {
                                        
                                        AsyncImage(url: URL(string: article.image_url)) { phase in
                                            
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 80, height: 80)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 80, height: 80)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 80, height: 80)
                                                    .foregroundColor(.gray)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            Text(article.title)
                                                .font(.headline)
                                            Text(article.source)
                                                .font(.caption)
                                            Text(article.description)
                                                .font(.subheadline)
                                        }
                                    }
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
