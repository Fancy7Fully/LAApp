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
  var entries: [[Float]];
  lazy var determinant: Float = {
    return findDeterminant(matrix: self.entries)
  }()
  
  var hasDeterminant: Bool = false;
  
  init(entryArray: [[Float]]) {
    entries = entryArray
    rowNumber = entryArray.count;
    colNumber = entryArray[0].count;
    super.init()
    if rowNumber == colNumber {
      hasDeterminant = true;
    }
  }
  
  private func findDeterminant(matrix: [[Float]]) -> Float {
    if (!hasDeterminant) {
      return Float.greatestFiniteMagnitude
    }
    
    if rowNumber == 1 && colNumber == 1 {
      return entries[0][0]
    }
    
    if rowNumber == 2 && colNumber == 2 {
      return entries[0][0] * entries[1][1] - entries[0][1] * entries[1][0]
    }
    
    var det: Float = 0;
    
    var entriesWithoutFirstRow: [[Float]] = []
    for i in 0...matrix.count - 1 {
      var columnEntry: [Float] = []
      for j in 1...matrix.count - 1 {
        columnEntry.append(entries[i][j])
      }
      entriesWithoutFirstRow.append(columnEntry)
    }
    
    for i in 0...matrix.count - 1 {
      var newEntries: [[Float]] = []
      for j in 0...matrix.count - 1 {
        if i != j {
          newEntries.append(entriesWithoutFirstRow[j])
        }
      }
      
      let currentMatrix: Matrix = Matrix.init(entryArray: newEntries)
      if i % 2 == 0 {
        det = det + currentMatrix.determinant * entries[i][0]
      } else {
        det = det - currentMatrix.determinant * entries[i][0]
      }
    }
    
    return det
  }
}
