//
//  NewsAPI.swift
//  Cryptocurrency Predictor
//
//  Created by Shreyas Veturi on 18/11/2024.
//

import Foundation

class NewsAPI: ObservableObject {
    static let shared = NewsAPI()
    
    @Published var articles: [Article] = []
    
    private let baseURL: String = "https://api.marketaux.com/v1/news/all?entity_types=cryptocurrency&language=en"
    private let apiKey: String = "bHraR8XR9eGBf6zK4xtq3BFDs9x0ik21MhbsTzek"
    
    func getNews(completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)&api_token=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(false)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(NewsAPIResult.self, from: data)
                DispatchQueue.main.async {
                    self.articles = result.data
                    completion(false)
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }.resume()
    }
}
