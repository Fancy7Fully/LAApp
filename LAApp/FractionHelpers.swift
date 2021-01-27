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
    return abs(d);
  }
  
  static func FractionToString(fraction: Fraction) -> String {
    let frac = fraction
    if (frac.numerator == 0) {
      return String(0)
    }
    
    if (frac.numerator < 0 && frac.denominator < 0) {
      frac.numerator = -frac.numerator
      frac.denominator = -frac.denominator
    }

    if (frac.numerator > 0 && frac.denominator < 0) {
      frac.numerator = -frac.numerator
      frac.denominator = -frac.denominator
    }
    
    if (frac.denominator != 1) {
      return String(frac.numerator) + "/" + String(frac.denominator)
    } else {
      return String(frac.numerator)
    }
  }
}
