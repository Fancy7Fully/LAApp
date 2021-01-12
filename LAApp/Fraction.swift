//
//  Fraction.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 1/5/21.
//  Copyright © 2021 Zhou Zhiyuan. All rights reserved.
//

import Foundation

class Fraction: NSObject {
  var numerator: Int
  var denominator: Int
  
  init(num: Int, denom: Int = 1) {
    numerator = num
    denominator = denom
    super.init()
  }
  
  func isInt() -> Bool {
    if numerator % denominator == 0 {
      return true
    }
    return false
  }
  
  func intValue() -> Int {
    return numerator / denominator
  }
  
  func floatValue() -> Float {
    return Float(numerator) / Float(denominator)
  }
  
  func add(frac: Fraction) -> Fraction {
    if (denominator == frac.denominator && denominator == 1) {
      return Fraction(num: numerator + frac.numerator)
    }
    
    let commonDenominator = denominator * frac.denominator
    let resultNumerator = commonDenominator / denominator * numerator + commonDenominator / frac.denominator * frac.numerator
    
    return Fraction(num: resultNumerator, denom: commonDenominator).simplify()
  }
  
  func minus(frac: Fraction) -> Fraction {
    if (denominator == frac.denominator && denominator == 1) {
      return Fraction(num: (numerator - frac.numerator))
    }
    
    let commonDenominator = denominator * frac.denominator
    let resultNumerator = commonDenominator / denominator * numerator - commonDenominator / frac.denominator * frac.numerator
    
    return Fraction(num: resultNumerator, denom: commonDenominator).simplify()
  }
  
  func multiply(frac: Fraction) -> Fraction {
    return Fraction(num: numerator * frac.numerator, denom: denominator * frac.denominator).simplify()
  }
  
  func simplify() -> Fraction {
    if (numerator == 0) {
      return Fraction(num: 0)
    } else if (numerator == 1) {
      return Fraction(num: 1, denom: denominator)
    } else if (denominator == 1) {
      return Fraction(num: numerator)
    }
    
    let divisor = FractionHelpers.gcd(a: numerator, b: denominator)
    return Fraction(num:numerator / divisor, denom: denominator / divisor)
  }
  
  func inverse() -> Fraction {
    return Fraction(num: denominator, denom: numerator)
  }
  
  func negate() -> Fraction {
    return Fraction(num: 0 - numerator, denom: denominator)
  }
}
