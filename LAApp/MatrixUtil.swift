//
//  MatrixUtil.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 1/10/21.
//  Copyright © 2021 Zhou Zhiyuan. All rights reserved.
//

import Foundation

enum MatrixUtilError: Error {
  case unsupportedCalculation, emptyMatrix
}

class MatrixUtil {
  static func Add(a: Matrix, b:Matrix) throws -> Matrix {
    if a.rowNumber != b.rowNumber || a.colNumber != b.colNumber {
      throw MatrixUtilError.unsupportedCalculation
    }
    
    if (a.rowNumber == 0 || a.colNumber == 0 || b.rowNumber == 0 || b.colNumber == 0) {
      throw MatrixUtilError.emptyMatrix
    }
    
    var resultArray: [[Fraction]] = []
    
    for i in 0..<a.rowNumber {
      var resultRow: [Fraction] = []
      for j in 0..<a.colNumber {
        resultRow.append(a.entries[i][j].add(frac: b.entries[i][j]))
      }
      resultArray.append(resultRow)
    }
    
    return Matrix(entryArray: resultArray)
  }
}
