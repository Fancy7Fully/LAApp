//
//  FractionTests.swift
//  LAAppTests
//
//  Created by Zhou Zhiyuan on 1/6/21.
//  Copyright © 2021 Zhou Zhiyuan. All rights reserved.
//

import XCTest
@testable import LAApp

class FractionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  func testFractionCreation() throws {
    let f1 = Fraction(num: 1)
    let f2 = Fraction(num: 2, denom: 3)
    
    XCTAssertEqual(f1.floatValue(), 1.0)
    XCTAssertEqual(f2.floatValue(), 2.0/3.0)
  }
  
  func testFractionAddition() throws {
    let f1 = Fraction(num: 1)
    let f2 = Fraction(num: 2, denom:  3)
    let f3 = Fraction(num: 3, denom: 4)
    
    XCTAssertEqual(f1.add(frac: f2).floatValue(), 5.0/3.0)
    XCTAssertEqual(f2.add(frac: f3).floatValue(), 17.0/12.0)
    XCTAssertEqual(f1.add(frac: f3).floatValue(), 7.0/4.0)
  }
  
  

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
