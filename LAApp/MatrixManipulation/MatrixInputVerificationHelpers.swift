//
//  MatrixInputVerificationHelpers.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 12/28/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation

class MatrixInputVerificationHelpers {
  static func InputOnlyContainsSupportedSymbols(text: String) -> Bool {
    return text.range(of: #"^(-*[0-9]*\/*\.*[0-9]*\s*\n*)*$"#, options: .regularExpression) != nil
  }
  
  static func InputContainsOnlyValidNumbers(text: String) -> Bool {
    return text.range(of:#"^(-?[0-9]+((\/|\.)?[0-9]+)?(\s|\n)*)*$"#, options: .regularExpression) != nil
  }
}
