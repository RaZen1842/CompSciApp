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

        override func setUpWithError() throws {
            api = MarketauxAPI()
        }
    
    override func tearDownWithError() throws {
            api = nil
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
    
    
}
