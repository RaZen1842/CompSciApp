//
//  Cryptocurrency_PredictorTests.swift
//  Cryptocurrency PredictorTests
//
//  Created by Veturi, Shreyas (HJRM) on 06/09/2024.
//

import XCTest
import Foundation
@testable import Cryptocurrency_Predictor

final class Cryptocurrency_PredictorTests: XCTestCase {
        
    var searchApi: SearchCurrenciesAPI!
    var financialApi: FinancialDataAPI!
    var historicalApi: HistoricalFinancialDataAPI!
    var discoverCurrenciesApi: DiscoverCurrenciesAPI!
    var newsApi: NewsAPI!
    var predictionManager: PredictionManager!
    
    
    override func setUpWithError() throws {
        searchApi = SearchCurrenciesAPI()
        financialApi = FinancialDataAPI()
        historicalApi = HistoricalFinancialDataAPI()
        discoverCurrenciesApi = DiscoverCurrenciesAPI()
        newsApi = NewsAPI()
        predictionManager = PredictionManager()
    }
        
    override func tearDownWithError() throws {
        searchApi = nil
        financialApi = nil
        historicalApi = nil
        discoverCurrenciesApi = nil
        newsApi = nil
        predictionManager = nil
    }
        
    func testSearchCryptos() throws {
        let expectation = self.expectation(description: "Fetching crypto (Bitcoin) from API using known symbol to return Bitcoin USD as the first element")
        
        searchApi.getAllCryptos { success in
            XCTAssertTrue(success, "API call should be successful")
            XCTAssertNotNil(self.searchApi.allCryptos, "Financial Data shouldn't return nil")
            XCTAssertFalse(self.searchApi.allCryptos.isEmpty, "All Cryptos should not be empty")
        }
        
        /*
        self.searchApi.searchCryptos(query: "BTCUSD")

        let topResult = self.searchApi.filteredCryptos.first
        XCTAssertNotNil(topResult, "Top result should not be nil")
        XCTAssertEqual(topResult?.symbol, "BTCUSD", "The top result should be 'Bitcoin USD'")
        */
        
        expectation.fulfill()
       
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //FINANCIAL DATA API TESTS
    
    func testFetchFinancialDataForCryptos() throws {
        let expectation = self.expectation(description: "Fetching financial data for BTCUSD from API")
        
        financialApi.getFinancialData(symbol: "BTCUSD") { success in
            DispatchQueue.main.async {
                XCTAssertTrue(success, "API call should be successful")
                XCTAssertNotNil(self.financialApi.cryptoFinancialData, "Financial Data shouldn't return nil")
                
                XCTAssertEqual(self.financialApi.cryptoFinancialData?.symbol, "BTCUSD", "Symbol should be BTCUSD")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //Historical Data API tests
    
    func testFetchHistoricalDataForCryptos() throws {
        let expectation = self.expectation(description: "Fetching historical financial data for BTCUSD from API")
        
        historicalApi.getAllCryptoHistoricalData(symbol: "BTCUSD") { success in
            DispatchQueue.main.async {
                XCTAssertTrue(success, "API call should be successful")
                XCTAssertNotNil(self.historicalApi.allData, "Historical Data shouldn't return nil")
                XCTAssertFalse(self.historicalApi.allData.isEmpty, "Historical Data should have values")
                
                if let firstEntry = self.historicalApi.allData.first {
                    XCTAssertEqual(firstEntry.date, "2025-03-08")
                }
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //Discover currencies API test
    
    func testGetting5DiscoveredCryptos() throws {
        let expectation = self.expectation(description: "Fetching 5 discovered cryptocurrencies from API")
        
        discoverCurrenciesApi.getTop5TrendingCryptos { success in
            DispatchQueue.main.async {
                XCTAssertTrue(success, "API call should be successful")
                XCTAssertNotNil(self.discoverCurrenciesApi.discoveredCryptos, "Discovered cryptocurrencies shouldn't return nil")
                XCTAssertFalse(self.discoverCurrenciesApi.discoveredCryptos.isEmpty, "Discovered cryptocurrencies should have values")
                XCTAssertEqual(self.discoverCurrenciesApi.discoveredCryptos.count, 5, "Discovered cryptocurrencies should have 5 values")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //News API test cases
    
    func testNewsApi() throws {
        let expectation = self.expectation(description: "Fetching news from API")
        
        newsApi.getNews { success in
            DispatchQueue.main.async {
                XCTAssertTrue(success, "API call should be successful")
                XCTAssertNotNil(self.newsApi.articles, "News shouldn't return nil")
                XCTAssertFalse(self.newsApi.articles.isEmpty, "News should have values")
                XCTAssertEqual(self.newsApi.articles.count, 3, "News should have 3 articles")
                
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //Prediction Manager Test Cases
    
    func testPredictionManager() throws {
        let expectation = self.expectation(description: "Fetching predictions for BTCUSD from API")
        
        //dummy data for HistoricalFinancialDataAPI
        historicalApi.getAllCryptoHistoricalData(symbol: "BTCUSD") { success in
            DispatchQueue.main.async {
                XCTAssertTrue(success, "Historical data fetch should succeed")
                XCTAssertNotNil(self.historicalApi.allData, "Historical data should not be nil")
                XCTAssertFalse(self.historicalApi.allData.isEmpty, "Historical data should have values")
                
                //getting predictions
                self.predictionManager.getPredictions(for: "BTCUSD") { success in
                    DispatchQueue.main.async {
                        XCTAssertTrue(success, "Prediction API call should be successful")
                        XCTAssertNotNil(self.predictionManager.predictedPrices, "Predicted prices should not be nil")
                        XCTAssertFalse(self.predictionManager.predictedPrices.isEmpty, "Predicted prices should have values")
                        
                        if let firstPrice = self.predictionManager.predictedPrices.first {
                            XCTAssertGreaterThan(firstPrice, 0, "First predicted price should be greater than 0")
                        }
                        
                        expectation.fulfill()
                    }
                }
            }
        }
        
        waitForExpectations(timeout: 70, handler: nil)
    }
}
