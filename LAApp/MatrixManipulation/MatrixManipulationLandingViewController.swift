//
//  MatrixManipulationViewController.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 10/12/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation
import UIKit

let defaultColor : UIColor = UIColor.init(displayP3Red: 0.0, green: 140.0/255.0, blue: 174.0/255.0, alpha: 1.0);

let buttonCornerRadius: CGFloat = 10.0;

class MatrixManipulationLandingViewController : UIViewController {
  var buttonArray: [UIButton] = [];
  var stackView: UIStackView = UIStackView();
  var titleLabel: UILabel = UILabel();
  
  // This allows you to initialise your custom UIViewController without a nib or bundle.
  convenience init() {
      self.init(nibName:nil, bundle:nil)
  }

  // This extends the superclass.
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    titleLabel.text = "Select matrix manipulation"
    titleLabel.textColor = .black;
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline);
    
    stackView.addArrangedSubview(titleLabel)

    for _ in 0...7 {
      let button: UIButton = UIButton()
      button.layer.cornerRadius = buttonCornerRadius
      button.backgroundColor = defaultColor
      button.widthAnchor.constraint(equalToConstant: 220.0).isActive = true
      buttonArray.append(button)
      stackView.addArrangedSubview(button)
    }
    
    buttonArray[0].setTitle("Matrix calculation", for: .normal)
    buttonArray[1].setTitle("LU decomposition", for: .normal)
    buttonArray[2].setTitle("QR decomposition", for: .normal)
    buttonArray[3].setTitle("Diagonalization", for: .normal)
    buttonArray[4].setTitle("REF & RREF", for: .normal)
    buttonArray[5].setTitle("Solution to Linear System", for: .normal)
    buttonArray[6].setTitle("Inverse and determinant", for: .normal)
    buttonArray[7].setTitle("Rank", for: .normal)
    
    buttonArray[0].addTarget(self, action: #selector(didTapMatrixCalculationButton), for: .touchUpInside)
    buttonArray[6].addTarget(self, action: #selector(didTapInverseAndRankButton), for: .touchUpInside)
    
    stackView.axis = .vertical;
    stackView.distribution = .equalSpacing;
    stackView.alignment = .center;
    stackView.spacing = 4.0;
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    stackView.layoutMargins = UIEdgeInsets.init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0);
    stackView.isLayoutMarginsRelativeArrangement = true;
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Button methods
  
  @objc func didTapMatrixCalculationButton() {
    let controller : UIViewController = MatrixCalculationSelectionViewController();
    
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func didTapInverseAndRankButton() {
    let controller: UIViewController =
        MatirxInverseAndRankViewController()
    
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
  // MARK: Lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.navigationController?.setNavigationBarHidden(false, animated: false);
    self.view.backgroundColor = .white;
    self.view.addSubview(stackView);
    
    let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 44.0;
    let deviceWidth: CGFloat = UIScreen.main.bounds.size.width;
    let deviceHeight: CGFloat = UIScreen.main.bounds.size.height;
    stackView.widthAnchor.constraint(equalToConstant: deviceWidth).isActive = true;
    stackView.heightAnchor.constraint(equalToConstant: deviceHeight - navigationBarHeight).isActive = true;
  }
}
