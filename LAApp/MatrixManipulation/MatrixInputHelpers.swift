//
//  MatrixInputVerificationHelpers.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 12/28/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation

class MatrixInputHelpers {
  static func InputOnlyContainsSupportedSymbols(text: String) -> Bool {
    return text.range(of: #"^(-*[0-9]*\/*[0-9]*\s*\n*)*$"#, options: .regularExpression) != nil
  }
  
  static func InputContainsOnlyValidNumbers(text: String) -> Bool {
    return text.range(of:#"^(-?[0-9]+(\/?[0-9]+)?(\s|\n)*)*$"#, options: .regularExpression) != nil
  }
  
  static func VerifyEntryNumberIsSameAcrossRows(text: String) -> Bool {
    let rows : [String] = (text.components(separatedBy: "\n")).filter{!$0.isEmpty}
    if (rows.count == 1) {
      return true
    } else {
      let entries = rows[0].components(separatedBy: .whitespaces);
      let filteredEntries = entries.filter {!$0.isEmpty}
      let entryNumber = filteredEntries.count;
      
      for row in rows {
        let rowEntries = row.components(separatedBy: .whitespaces)
        let filteredRowEntries = rowEntries.filter{!$0.isEmpty}
        let rowEntryNumber = filteredRowEntries.count
        if (rowEntryNumber != entryNumber) {
          return false
        }
      }
    }
    
    return true
  }
  
  static func ParseInput(text: String) -> Matrix {
    let rows : [String] = (text.components(separatedBy: "\n")).filter{!$0.isEmpty}
    var entries : [[Fraction]] = []
    rows.forEach{ row in
      entries.append(
        row.components(separatedBy: .whitespaces).filter{!$0.isEmpty}.map{
          TurnToFraction(text: $0)
        }
      )
    }
    return Matrix(entryArray: entries)
  }
  
  static func TurnToFraction(text: String) -> Fraction {
    let index = text.firstIndex(of: "/")
    if (index == nil) {
      return Fraction(num: Int(text)!)
    } else {
      return Fraction(num: Int(text[..<index!])!, denom: Int(text[text.index(after: index!)...])!)
    }
  }
  
  static func TextFromMatrix(matrix: Matrix) -> String {
    var text: String = ""
    for row in matrix.entries {
      let rowToString = row.map{FractionHelpers.FractionToString(fraction: $0)}.joined(separator: " ")
      text = text + rowToString + "\n"
    }
    return text;
  }
  
  static func CalculateDenominator(text: String) -> Int {
    var txt = text;
    var index = text.firstIndex(of: "/") ?? nil
    var denominator = 1;
    while (index != nil) {
      let idxAfter = txt.index(after: index!)
      txt = String(txt[idxAfter...])
      let firstSpaceAfter = txt.firstIndex(of: " ") ?? txt.endIndex
      let firstEOLAfter = txt.firstIndex(of: "\n") ?? txt.endIndex
      var denomEndIndex = txt.startIndex
      if (firstEOLAfter < firstSpaceAfter) {
        denomEndIndex = firstEOLAfter
      } else {
        denomEndIndex = firstSpaceAfter
      }
      let denom = Int(txt[..<denomEndIndex])
      denominator = denominator * denom!
      index = txt.firstIndex(of: "/") ?? nil
    }
    return denominator
  }
}

