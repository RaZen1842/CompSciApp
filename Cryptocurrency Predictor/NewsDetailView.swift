//
//  NewsDetailView.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 19/11/2024.
//

import SwiftUI

struct NewsDetailView: View {
    let article: Article
    
    var body: some View {
        VStack {
            Text(article.title)
                .font(.headline)
                .bold()
            
            Form {
                Section {
                    
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
                    
                    Text(article.snippet)
                        .font(.headline)
                    Link("Read more", destination: URL(string: article.url)!)
                    
                }
            }
        }
    }
}

#Preview {
    NewsDetailView(article: Article(uuid: "9b9fb67e-9438-4263-815e-ef6a7d36af07", title: "Test", description: "Test", snippet: "", url: "Test", image_url: "", published_at: "", source: ""))
}
