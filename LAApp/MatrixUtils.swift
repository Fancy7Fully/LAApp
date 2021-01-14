//
//  MatrixUtil.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 1/10/21.
//  Copyright © 2021 Zhou Zhiyuan. All rights reserved.
//

import Foundation

enum MatrixUtilError: Error {
  case unsupportedCalculation, emptyMatrix, noInverse
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
      let result = entries[rowNumber][i].multiply(frac: multiplier)
      entries[rowNumber][i] = result
    }
    
    return Matrix(entryArray: entries)
  }
  
  static func IdentityMatrix(size: Int) -> Matrix {
    var entries: [[Fraction]] = []
    for i in 0..<size {
      var row: [Fraction] = []
      for j in 0..<size {
        if (i == j) {
          row.append(Fraction(num: 1))
        } else {
          row.append(Fraction(num: 0))
        }
      }
      entries.append(row)
    }
    
    return Matrix(entryArray: entries)
  }
  
  static func FindInverse(matrix: Matrix) throws -> Matrix{
    if matrix.rowNumber != matrix.colNumber {
      throw MatrixUtilError.unsupportedCalculation
    }
    
    if (matrix.determinant == 0) {
      throw MatrixUtilError.noInverse
    }
    
    if (matrix.rowNumber == 1) {
      return Matrix(entryArray: [[matrix.entries[0][0].inverse()]])
    }
    
    if (matrix.rowNumber == 2) {
      // ad - bc
      let multiplierDenom = matrix.entries[0][0].multiply(frac: matrix.entries[1][1]).minus(frac: matrix.entries[0][1].multiply(frac: matrix.entries[1][0]))
      
      let multiplier = multiplierDenom.inverse()
      return Matrix(entryArray: [
        [matrix.entries[0][0].multiply(frac: multiplier), matrix.entries[0][1].multiply(frac: multiplier)],
        [matrix.entries[1][0].multiply(frac: multiplier), matrix.entries[1][1].multiply(frac: multiplier)]
      ])
    }
    
    var currentRow = 0
    let totalRows = matrix.entries.count
    var inverseMatrix = MatrixUtils.IdentityMatrix(size: totalRows)
    var m = matrix
    while (currentRow < totalRows) {
      let currentCol = currentRow
      if (m.entries[currentRow][currentCol].floatValue() == 0.0) {
        var rowToSwap = currentRow;
        for i in (currentRow + 1)..<totalRows {
          if (m.entries[i][currentCol].floatValue() != 0.0) {
            rowToSwap = i;
            break;
          }
        }
        m = MatrixUtils.ElementarySwapOperation(rowNumberA: currentRow, rowNumberB: rowToSwap, matrix: m)
        inverseMatrix = MatrixUtils.ElementarySwapOperation(rowNumberA: currentRow, rowNumberB: rowToSwap, matrix: inverseMatrix)
      } else {
          let multiplier = m.entries[currentRow][currentCol].inverse()
          m = MatrixUtils.ElementaryScaleOperation(rowNumber: currentRow, matrix: m, multiplier: multiplier)
          inverseMatrix = MatrixUtils.ElementaryScaleOperation(rowNumber: currentRow, matrix: inverseMatrix, multiplier: multiplier)
          for i in 0..<totalRows {
            if (m.entries[i][currentCol].floatValue() != 0 && i != currentRow) {
              let multiplier = m.entries[i][currentCol].negate()
              m = MatrixUtils.ElementaryAddOperation(rowNumberA: i, rowNumberB: currentRow, matrix: m, multiplier: multiplier)
              inverseMatrix = MatrixUtils.ElementaryAddOperation(rowNumberA: i, rowNumberB: currentRow, matrix: inverseMatrix, multiplier: multiplier)
            }
          }
        currentRow = currentRow + 1
      }
    }
    
    return inverseMatrix
  }
  
  static func REF(matrix: Matrix) -> Matrix {
    if (matrix.colNumber < 1 || matrix.rowNumber < 1) {
      return Matrix(entryArray: [[]])
    }
    
    var currentRow = 0
    let totalRows = matrix.entries.count
    let totalCols = matrix.entries[0].count
    var m = matrix
    while (currentRow < totalRows && currentRow < totalCols) {
      let currentCol = currentRow
      if (m.entries[currentRow][currentCol].floatValue() == 0.0) {
        var rowToSwap = currentRow;
        for i in (currentRow + 1)..<totalRows {
          if (m.entries[i][currentCol].floatValue() != 0.0) {
            rowToSwap = i;
            break;
          }
        }
        if (rowToSwap == currentRow) {
          currentRow = currentRow + 1
        } else {
          m = MatrixUtils.ElementarySwapOperation(rowNumberA: currentRow, rowNumberB: rowToSwap, matrix: m)
        }
      } else {
          let multiplier = m.entries[currentRow][currentCol].inverse()
          m = MatrixUtils.ElementaryScaleOperation(rowNumber: currentRow, matrix: m, multiplier: multiplier)
          for i in (currentRow + 1)..<totalRows {
            if (m.entries[i][currentCol].floatValue() != 0) {
              let multiplier = m.entries[i][currentCol].negate()
              m = MatrixUtils.ElementaryAddOperation(rowNumberA: i, rowNumberB: currentRow, matrix: m, multiplier: multiplier)
            }
          }
        currentRow = currentRow + 1
      }
    }
    
    return m
  }
  
  static func findRank(matrix: Matrix) -> Int {
    let ref = MatrixUtils.REF(matrix: matrix)
    var count = 0
    for i in 0..<ref.rowNumber {
      var allZero = true
      for j in 0..<ref.colNumber {
        if (ref.entries[i][j].floatValue() != 0.0) {
          count = count + 1
          allZero = false
          break
        }
      }
      if (allZero) {
        break
      }
    }
    
    return count
  }
}
