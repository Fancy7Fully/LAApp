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
  var matrixInputField: UITextField = UITextField()
  
  convenience init(type: calculationType) {
    self.init(nibName:nil, bundle:nil, type: type)
  }
  
  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, type: calculationType) {
    matrixCalculationType = type
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setUp()
  }
  
  func setUp() {
    titleLabel.text = "Please Enter Matrix A"
    titleLabel.textColor = .black
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    vStackView.addArrangedSubview(titleLabel)
    
    matrixInputField.placeholder =
      """
      You can enter your matrix like: \
      1 2 3 \
      4 5 6 \
      7 8 9
      """;
    matrixInputField.backgroundColor = .lightGray
    matrixInputField.widthAnchor.constraint(equalToConstant: 200.0).isActive = true;
    matrixInputField.heightAnchor.constraint(equalToConstant: 120.0).isActive = true;
    matrixInputField.borderStyle = .roundedRect
    matrixInputField.keyboardType = .numberPad
    
    vStackView.addArrangedSubview(matrixInputField);
    vStackView.axis = .vertical
    vStackView.distribution = .equalSpacing
    vStackView.alignment = .center
    vStackView.spacing = 4.0
    vStackView.translatesAutoresizingMaskIntoConstraints = false
    vStackView.layoutMargins = UIEdgeInsets.init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0);
    vStackView.isLayoutMarginsRelativeArrangement = true;
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.view.backgroundColor = .white
    self.view.addSubview(vStackView)
    
    let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 44.0;
    let deviceWidth: CGFloat = UIScreen.main.bounds.size.width;
    let deviceHeight: CGFloat = UIScreen.main.bounds.size.height;
    vStackView.widthAnchor.constraint(equalToConstant: deviceWidth).isActive = true;
    vStackView.heightAnchor.constraint(equalToConstant: deviceHeight - navigationBarHeight).isActive = true;
  }
}
