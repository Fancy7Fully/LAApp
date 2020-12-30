//
//  LAAppTests.swift
//  LAAppTests
//
//  Created by Zhou Zhiyuan on 9/27/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import XCTest
@testable import LAApp

class MatrixInputVerificationTests: XCTestCase {
  
  func testMatrixInputHasInvalidSymbols() throws {
    let text1 = "abce"
    let text2 = "a123 1ab2"
    let text3 = "+12 4 5"
    let text4 = ". , / 1 2 5"
    let text5 = "1 2 3 \n 4 $ 5"
    let text6 = "8) 19 2"
    XCTAssertFalse(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text1))
    XCTAssertFalse(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text2))
    XCTAssertFalse(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text3))
    XCTAssertFalse(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text4))
    XCTAssertFalse(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text5))
    XCTAssertFalse(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text6))
  }
  
  func testMatrixInputHasValidSymbols() throws {
    let text1 = "1 2 3 \n 4 5 6"
    let text2 = "123"
    let text3 = "-12 4 5"
    let text4 = "1/2 2.2 \n 4 3.2"
    let text5 = "1 2 3 \n 4 0.2 5"
    let text6 = "-2.1 -12 -3/5"
    let text7 = "123-/.234"
    XCTAssertTrue(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text1))
    XCTAssertTrue(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text2))
    XCTAssertTrue(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text3))
    XCTAssertTrue(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text4))
    XCTAssertTrue(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text5))
    XCTAssertTrue(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text6))
    XCTAssertTrue(MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: text7))
  }
  
  func testMatrixInputHasInvalidNumbers() throws {
    let text1 = "1. 2 4 5"
    let text2 = "1/2 /3"
    let text3 = "2/-3 0"
    let text4 = "2.2/3 12"
    let text5 = "1/2. 3 4"
    XCTAssertFalse(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text1))
    XCTAssertFalse(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text2))
    XCTAssertFalse(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text3))
    XCTAssertFalse(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text4))
    XCTAssertFalse(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text5))
  }
  
  func testMatrixInputHasValidNumbers() throws {
    let text1 = "1.2 2 3 \n 4 5 6"
    let text2 = "1/2 -2 3.4 \n 2 3 4.4 \n 0.1 1 2"
    let text3 = "1 2 3 \n 3 4 5"
    let text4 = "0"
    let text5 = "-0.2 2 3"
    XCTAssertTrue(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text1))
    XCTAssertTrue(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text2))
    XCTAssertTrue(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text3))
    XCTAssertTrue(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text4))
    XCTAssertTrue(MatrixInputHelpers.InputContainsOnlyValidNumbers(text: text5))
  }

  func testMatrixRowEntryNumberIsDifferent() throws {
    let text1 = "1 2 3 \n 4 5"
    let text2 = "1 2 \n 3 4 \n 5 6 7"
    let text3 = "1 2 \n 3 4 5 \n"
    let text4 = "1  2 3 \n 4  5    \n"
    XCTAssertFalse(MatrixInputHelpers.VerifyEntryNumberIsSameAcrossRows(text: text1))
    XCTAssertFalse(MatrixInputHelpers.VerifyEntryNumberIsSameAcrossRows(text: text2))
    XCTAssertFalse(MatrixInputHelpers.VerifyEntryNumberIsSameAcrossRows(text: text3))
    XCTAssertFalse(MatrixInputHelpers.VerifyEntryNumberIsSameAcrossRows(text: text4))
  }
  
  func testMatrixRowEntryNumberIsSame() throws {
    let text1 = "1 2 3 \n 4 5 6"
    let text2 = "1 2 \n 3 4 \n 5 6"
    let text3 = "1 2.2 -3 \n -3/4    4 5.002 \n"
    let text4 = "1  2 3 \n 4  5 67   \n"
    XCTAssertTrue(MatrixInputHelpers.VerifyEntryNumberIsSameAcrossRows(text: text1))
    XCTAssertTrue(MatrixInputHelpers.VerifyEntryNumberIsSameAcrossRows(text: text2))
    XCTAssertTrue(MatrixInputHelpers.VerifyEntryNumberIsSameAcrossRows(text: text3))
    XCTAssertTrue(MatrixInputHelpers.VerifyEntryNumberIsSameAcrossRows(text: text4))
  }
}
