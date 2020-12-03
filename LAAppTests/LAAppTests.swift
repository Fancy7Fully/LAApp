//
//  LAAppTests.swift
//  LAAppTests
//
//  Created by Zhou Zhiyuan on 9/27/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import XCTest
@testable import LAApp

class LAAppTests: XCTestCase {
  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
  
  func test2By2MatrixCreation() throws {
    let col1: [Float] = [1, 2]
    let col2: [Float] = [3, 4]
    let matrix: Matrix = Matrix.init(entryArray: [col1, col2])
    let matrixEntries: [[Float]] = matrix.entries
    XCTAssertEqual(matrixEntries[0][0], 1.0)
    XCTAssertEqual(matrixEntries[0][1], 2.0)
    XCTAssertEqual(matrixEntries[1][0], 3.0)
    XCTAssertEqual(matrixEntries[1][1], 4.0)
  }
  
  func test1By1MatrixCreation() throws {
    let matrix: Matrix = Matrix.init(entryArray: [[1.0]])
    let matrixEntris: [[Float]] = matrix.entries
    XCTAssertEqual(matrixEntris[0][0], 1.0)
  }
  
  func test3By3MatrixCreation() throws {
    let col1: [Float] = [1, 2, 3]
    let col2: [Float] = [4, 5, 6]
    let col3: [Float] = [7, 8, 9]
    let matrix: Matrix = Matrix.init(entryArray: [col1, col2, col3])
    let matrixEntries: [[Float]] = matrix.entries
    XCTAssertEqual(matrixEntries[0][0], 1.0)
    XCTAssertEqual(matrixEntries[0][1], 2.0)
    XCTAssertEqual(matrixEntries[0][2], 3.0)
    XCTAssertEqual(matrixEntries[1][0], 4.0)
    XCTAssertEqual(matrixEntries[1][1], 5.0)
    XCTAssertEqual(matrixEntries[1][2], 6.0)
    XCTAssertEqual(matrixEntries[2][0], 7.0)
    XCTAssertEqual(matrixEntries[2][1], 8.0)
    XCTAssertEqual(matrixEntries[2][2], 9.0)
  }
  
  func test4By2MatrixCreation() throws {
    let col1: [Float] = [1, 2, 3, 4]
    let col2: [Float] = [5, 6, 7, 8]
    let matrix: Matrix = Matrix.init(entryArray: [col1, col2])
    let matrixEntries: [[Float]] = matrix.entries
    XCTAssertEqual(matrixEntries[0][0], 1.0)
    XCTAssertEqual(matrixEntries[0][1], 2.0)
    XCTAssertEqual(matrixEntries[0][2], 3.0)
    XCTAssertEqual(matrixEntries[0][3], 4.0)
    XCTAssertEqual(matrixEntries[1][0], 5.0)
    XCTAssertEqual(matrixEntries[1][1], 6.0)
    XCTAssertEqual(matrixEntries[1][2], 7.0)
    XCTAssertEqual(matrixEntries[1][3], 8.0)
  }
  
  func test1By1MatrixDeterminant() throws {
    let matrix: Matrix = Matrix.init(entryArray: [[1.0]])
    XCTAssertEqual(matrix.determinant, 1.0)
  }
  
  func test2By2MatrixDeterminant1() throws {
    let col1: [Float] = [1, 0]
    let col2: [Float] = [1, 0]
    let matrix: Matrix = Matrix.init(entryArray: [col1, col2])
    XCTAssertEqual(matrix.determinant, 0.0)
  }
  
  func test2By2MatrixDeterminant2() throws {
    let col1: [Float] = [1, 0]
    let col2: [Float] = [0, 1]
    let matrix: Matrix = Matrix.init(entryArray: [col1, col2])
    XCTAssertEqual(matrix.determinant, 1.0)
  }
  
  func test3By3MatrixDeterminant() throws{
    let col1: [Float] = [0, 4, 7]
    let col2: [Float] = [1, 2, 8]
    let col3: [Float] = [3, 6, 9]
    let matrix: Matrix = Matrix.init(entryArray: [col1, col2, col3])
    XCTAssertEqual(matrix.determinant, 60.0)
    
  }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
