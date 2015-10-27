//
//  ArmyOfOnesTests.swift
//  ArmyOfOnesTests
//
//  Created by Giorgia Marenda on 10/26/15.
//  Copyright © 2015 Giorgia Marenda. All rights reserved.
//

import XCTest
@testable import ArmyOfOnes

class ArmyOfOnesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCurrenctAPI() {
        let expectation = self.expectationWithDescription("Successful request")
        
        CurrencyAPI.convertion(from: .US, to: .UK, amount: 2) { (c, e) -> Void in
            XCTAssertNotNil(c, "Conversion is mapped")
            XCTAssertEqual(c?.source, "USD", "Test correct source returned")
            XCTAssertEqual(c?.target, "GBP", "Test correct target returned")
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(2.0, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
