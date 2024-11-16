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
        
    var api: SearchCurrenciesAPI!
    var financialApi: FinancialDataAPI!
    var historicalApi: HistoricalFinancialDataAPI!
    
    
    override func setUpWithError() throws {
        api = SearchCurrenciesAPI()
        financialApi = FinancialDataAPI()
        historicalApi = HistoricalFinancialDataAPI()
    }
        
    override func tearDownWithError() throws {
        api = nil
        financialApi = nil
        historicalApi = nil
    }
        
    func testFetchCryptos() throws {
        let expectation = self.expectation(description: "Fetching crypto (Bitcoin) from API")
            
        api.searchCryptos(query: "bitcoin")
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.api.allCryptos.isEmpty, "The cryptos array should not be empty after fetching data.")
            
            /*
            let firstCrypto = self.api.filteredCryptos.first
             
            XCTAssertEqual(firstCrypto?., "cryptocurrency", "The first item should be a cryptocurrency.")
            XCTAssertEqual(firstCrypto?.name, "Bitcoin")
            */
            expectation.fulfill()
        }
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
}
