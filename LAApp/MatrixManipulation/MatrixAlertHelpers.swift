//
//  MatrixAlertHelpers.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 12/27/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation
import UIKit

enum MatrixInputAlertType{
  case ContainsInvalidCharacters, ContainsInvalidNumbers, EmptyInput
}

class MatrixAlertHelper {
  static func AlertControllerWithMatrixInputAlertType(type: MatrixInputAlertType) -> UIAlertController {
    switch (type) {
      case .ContainsInvalidCharacters:
        let alert = UIAlertController(title: "Invalid Matrix Input",
                                 message: "The matrix input contains unrecognized character(s). Please check and correct the input before moving on to next step.",
                                 preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    case .ContainsInvalidNumbers:
      let alert = UIAlertController(title: "Invalid Matrix Input",
                                 message: "The matrix input contains invalid number(s). Please check and correct the input before moving on to next step.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      return alert
    case .EmptyInput:
      let alert = UIAlertController(title: "Invalid Matrix Input",
                               message: "The matrix input is empty. Please enter a valid matrix before moving on to next step.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      return alert
    }
  }
}
