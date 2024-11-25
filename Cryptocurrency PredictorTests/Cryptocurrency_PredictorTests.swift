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
    
    
    override func setUpWithError() throws {
        searchApi = SearchCurrenciesAPI()
        financialApi = FinancialDataAPI()
        historicalApi = HistoricalFinancialDataAPI()
        discoverCurrenciesApi = DiscoverCurrenciesAPI()
    }
        
    override func tearDownWithError() throws {
        searchApi = nil
        financialApi = nil
        historicalApi = nil
        discoverCurrenciesApi = nil
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
                    XCTAssertEqual(firstEntry.date, "2024-11-03")
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
}
