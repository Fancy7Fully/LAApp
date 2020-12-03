//
//  File.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 10/30/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation
import UIKit

class MatrixCalculationInputViewController : UIViewController {
  var vStackView: UIStackView = UIStackView()
  var hStackView: UIStackView = UIStackView()
  var titleLabel: UILabel = UILabel()
  var matrixCalculationType: calculationType;
  
  
  convenience init(type: calculationType) {
    self.init(nibName:nil, bundle:nil, type: type)
  }
  
  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, type: calculationType) {
    matrixCalculationType = type
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  func setUp() {
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
