//
//  Cryptocurrency_PredictorTests.swift
//  Cryptocurrency PredictorTests
//
//  Created by Veturi, Shreyas (HJRM) on 06/09/2024.
//

import XCTest
@testable import Cryptocurrency_Predictor

final class Cryptocurrency_PredictorTests: XCTestCase {
        
    var api: MarketauxAPI!
    var financialApi: FinancialDataAPI!
        
    override func setUpWithError() throws {
        api = MarketauxAPI()
        financialApi = FinancialDataAPI()
    }
        
    override func tearDownWithError() throws {
        api = nil
        financialApi = nil
    }
        
    func testFetchCryptos() throws {
        let expectation = self.expectation(description: "Fetching crypto (Bitcoin) from API")
            
        api.getCrypto(query: "bitcoin")
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.api.cryptos.isEmpty, "The cryptos array should not be empty after fetching data.")
            let firstCrypto = self.api.cryptos.first
            XCTAssertEqual(firstCrypto?.type, "cryptocurrency", "The first item should be a cryptocurrency.")
            XCTAssertEqual(firstCrypto?.name, "Bitcoin")
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
}
