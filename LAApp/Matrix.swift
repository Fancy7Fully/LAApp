//
//  Matrix.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 10/30/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation

class Matrix: NSObject {
  var rowNumber: NSInteger;
  var colNumber: NSInteger;
  var entries: [[Fraction]];
  lazy var determinant: Float = {
    return findDeterminant(matrix: self.entries)
  }()
  
  var hasDeterminant: Bool = false;
  
  init(entryArray: [[Fraction]], denominator: Int = 1) {
    entries = entryArray
    rowNumber = entryArray.count;
    colNumber = entryArray[0].count;
    super.init()
    if rowNumber == colNumber {
      hasDeterminant = true;
    }
  }
  
  private func findDeterminant(matrix: [[Fraction]]) -> Float {
    if (!hasDeterminant) {
      return Float.greatestFiniteMagnitude
    }
    
    if rowNumber == 1 && colNumber == 1 {
      return entries[0][0].floatValue()
    }
    
    if rowNumber == 2 && colNumber == 2 {
      return entries[0][0].floatValue() * entries[1][1].floatValue() - entries[0][1].floatValue() * entries[1][0].floatValue()
    }
    
    var det: Float = 0;
    
    var entriesWithoutFirstCol: [[Fraction]] = []
    for i in 0..<matrix.count {
      var columnEntry: [Fraction] = []
      for j in 1..<matrix.count {
        columnEntry.append(entries[i][j])
      }
      entriesWithoutFirstCol.append(columnEntry)
    }
    
    for i in 0..<matrix.count {
      var newEntries: [[Fraction]] = []
      for j in 0..<matrix.count {
        if i != j {
          newEntries.append(entriesWithoutFirstCol[j])
        }
      }
      
      let currentMatrix: Matrix = Matrix.init(entryArray: newEntries)
      if i % 2 == 0 {
        det = det + currentMatrix.determinant * entries[i][0].floatValue()
      } else {
        det = det - currentMatrix.determinant * entries[i][0].floatValue()
      }
    }
    
    return det
  }
}
