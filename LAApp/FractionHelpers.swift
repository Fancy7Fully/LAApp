//
//  FractionHelpers.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 1/5/21.
//  Copyright © 2021 Zhou Zhiyuan. All rights reserved.
//

import Foundation

class FractionHelpers {
  static func gcd(a: Int, b: Int) -> Int {
    var c = a
    var d = b
    var r = c % d
    while (r != 0) {
      c = d
      d = r
      r = c % d
    }
    return d;
  }
  
  static func FractionToString(fraction: Fraction) -> String {
    if (fraction.denominator != 1) {
      return String(fraction.numerator) + "/" + String(fraction.denominator)
    } else {
      return String(fraction.numerator)
    }
  }
}
