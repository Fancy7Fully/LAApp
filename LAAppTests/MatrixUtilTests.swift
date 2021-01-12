//
//  MatrixUtilTests.swift
//  LAAppTests
//
//  Created by Zhou Zhiyuan on 1/11/21.
//  Copyright © 2021 Zhou Zhiyuan. All rights reserved.
//

import XCTest
@testable import LAApp

class MatrixUtilTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testElementaryAddOperation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let text1 = "1 2 \n 3 4"
      let matrix1 = MatrixInputHelpers.ParseInput(text: text1)
      let result1 = MatrixUtils.ElementaryAddOperation(rowNumberA: 0, rowNumberB: 1, matrix: matrix1, multiplier: Fraction(num: 2))
                                                       
      XCTAssertEqual(result1.entries[0][0].floatValue(), 7.0)
      XCTAssertEqual(result1.entries[0][1].floatValue(), 10.0)
      XCTAssertEqual(result1.entries[1][0].floatValue(), 3.0)
      XCTAssertEqual(result1.entries[1][1].floatValue(), 4.0)
      
      let text2 = "1 2 3\n 3 4 5 \n 6 7 8"
      let matrix2 = MatrixInputHelpers.ParseInput(text: text2)
      let result2 = MatrixUtils.ElementaryAddOperation(rowNumberA: 1, rowNumberB: 0, matrix: matrix2, multiplier: Fraction(num: 1))
                                                       
      XCTAssertEqual(result2.entries[0][0].floatValue(), 1.0)
      XCTAssertEqual(result2.entries[0][1].floatValue(), 2.0)
      XCTAssertEqual(result2.entries[0][2].floatValue(), 3.0)
      XCTAssertEqual(result2.entries[1][0].floatValue(), 4.0)
      XCTAssertEqual(result2.entries[1][1].floatValue(), 6.0)
      XCTAssertEqual(result2.entries[1][2].floatValue(), 8.0)
      XCTAssertEqual(result2.entries[2][0].floatValue(), 6.0)
      XCTAssertEqual(result2.entries[2][1].floatValue(), 7.0)
      XCTAssertEqual(result2.entries[2][2].floatValue(), 8.0)
    }
  
  func testElementarySwapOperation() throws {
      // This is an example of a functional test case.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
    let text1 = "1 2 \n 3 4"
    let matrix1 = MatrixInputHelpers.ParseInput(text: text1)
    let result1 = MatrixUtils.ElementarySwapOperation(rowNumberA: 0, rowNumberB: 1, matrix: matrix1)
                                                     
    XCTAssertEqual(result1.entries[0][0].floatValue(), 3.0)
    XCTAssertEqual(result1.entries[0][1].floatValue(), 4.0)
    XCTAssertEqual(result1.entries[1][0].floatValue(), 1.0)
    XCTAssertEqual(result1.entries[1][1].floatValue(), 2.0)
  }
  
  func testElementaryScaleOperation() throws {
      // This is an example of a functional test case.
      // Use XCTAssert and related functions to verify your tests produce the correct results.
    let text1 = "1 2 \n 3 4"
    let matrix1 = MatrixInputHelpers.ParseInput(text: text1)
    let result1 = MatrixUtils.ElementaryScaleOperation(rowNumber: 0, matrix: matrix1, multiplier: Fraction(num: 2))
                                                     
    XCTAssertEqual(result1.entries[0][0].floatValue(), 2.0)
    XCTAssertEqual(result1.entries[0][1].floatValue(), 4.0)
    XCTAssertEqual(result1.entries[1][0].floatValue(), 3.0)
    XCTAssertEqual(result1.entries[1][1].floatValue(), 4.0)
  }
  
  func testInverse() throws {
    let text1 = "1 0 \n 0 1"
    let matrix1 = MatrixInputHelpers.ParseInput(text: text1)
    let result1 = try MatrixUtils.FindInverse(matrix: matrix1)
    
    XCTAssertEqual(result1.entries[0][0].floatValue(), 1.0)
    XCTAssertEqual(result1.entries[0][1].floatValue(), 0.0)
    XCTAssertEqual(result1.entries[1][0].floatValue(), 0.0)
    XCTAssertEqual(result1.entries[1][1].floatValue(), 1.0)
    
    let text2 = "1 1 3 \n 0 2 4 \n 1 3 5"
    let matrix2 = MatrixInputHelpers.ParseInput(text: text2)
    let result2 = try MatrixUtils.FindInverse(matrix: matrix2)
    
    XCTAssertEqual(result2.entries[0][0].floatValue(), 0.5)
    XCTAssertEqual(result2.entries[0][1].floatValue(), -1.0)
    XCTAssertEqual(result2.entries[0][2].floatValue(), 0.5)
    XCTAssertEqual(result2.entries[1][0].floatValue(), -1.0)
    XCTAssertEqual(result2.entries[1][1].floatValue(), -0.5)
    XCTAssertEqual(result2.entries[1][2].floatValue(), 1.0)
    XCTAssertEqual(result2.entries[2][0].floatValue(), 0.5)
    XCTAssertEqual(result2.entries[2][1].floatValue(), 0.5)
    XCTAssertEqual(result2.entries[2][2].floatValue(), -0.5)
  }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
