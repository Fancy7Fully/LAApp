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

class MatrixUtils {
  static func Sum(a: Matrix, b:Matrix) throws -> Matrix {
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
  
  static func Difference(a: Matrix, b: Matrix) throws -> Matrix {
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
        resultRow.append(a.entries[i][j].minus(frac: b.entries[i][j]))
      }
      resultArray.append(resultRow)
    }
    
    return Matrix(entryArray: resultArray)
  }
  
  static func Product(a: Matrix, b: Matrix) throws -> Matrix {
    if (a.rowNumber == 0 || a.colNumber == 0 || b.rowNumber == 0 || b.colNumber == 0) {
      throw MatrixUtilError.emptyMatrix
    }
    
    if (a.colNumber != b.rowNumber) {
      throw MatrixUtilError.unsupportedCalculation
    }
    
    var resultArray: [[Fraction]] = []
    for i in 0..<a.rowNumber {
      var resultRow: [Fraction] = []
      for j in 0..<b.colNumber {
        var result: Fraction = Fraction(num: 0)
        for k in 0..<a.colNumber {
          let product = a.entries[i][k].multiply(frac: b.entries[k][j])
          result = result.add(frac: product)
        }
        resultRow.append(result)
      }
      resultArray.append(resultRow)
    }
    
    return Matrix(entryArray: resultArray)
  }
  
  static func ElementaryAddOperation(rowNumberA: Int, rowNumberB: Int, matrix: Matrix, multiplier: Fraction) -> Matrix {
    // Performs the elementary row option where
    // rowNumberA = rowNumberA + multiplier * rowNumberB
    var entries = matrix.entries
    for i in 0..<entries[0].count {
      var entry = entries[rowNumberA][i]
      entry = entry.add(frac: entries[rowNumberB][i].multiply(frac: multiplier))
      entries[rowNumberA][i] = entry
    }
    
    return Matrix(entryArray: entries)
  }
  
  static func ElementarySwapOperation(rowNumberA: Int, rowNumberB: Int, matrix: Matrix) -> Matrix {
    var entries = matrix.entries
    for i in 0..<entries[0].count {
      let entry = entries[rowNumberA][i]
      entries[rowNumberA][i] = entries[rowNumberB][i]
      entries[rowNumberB][i] = entry
    }
    
    return Matrix(entryArray: entries)
  }
  
  static func ElementaryScaleOperation(rowNumber: Int, matrix: Matrix, multiplier: Fraction) -> Matrix {
    var entries = matrix.entries
    for i in 0..<entries[0].count {
      entries[rowNumber][i] = entries[rowNumber][i].multiply(frac: multiplier)
    }
    
    return Matrix(entryArray: entries)
  }
}
