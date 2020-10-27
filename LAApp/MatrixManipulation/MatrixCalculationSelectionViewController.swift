//
//  MatrixCalculationSelectionViewController.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 10/26/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation
import UIKit

class MatrixCalculationSelectionViewController: UIViewController {
  var buttonArray: [UIButton] = [];
  var titleLabel: UILabel = UILabel();
  var stackView: UIStackView = UIStackView();
  
  convenience init() {
    self.init(nibName: nil, bundle: nil);
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    
    titleLabel.text = "Select matrix calculation";
    titleLabel.textColor = .black;
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline);
    stackView.addArrangedSubview(titleLabel);
    
    for _ in 0...8 {
      let button: UIButton = UIButton();
      button.backgroundColor = defaultColor;
      button.layer.cornerRadius = buttonCornerRadius;
      button.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
      
      buttonArray.append(button);
      stackView.addArrangedSubview(button);
    }
    
    buttonArray[0].setTitle("A + B", for: .normal);
    buttonArray[1].setTitle("A - B", for: .normal);
    buttonArray[2].setTitle("A x B", for: .normal);
    buttonArray[3].setTitle("A + B x C", for: .normal);
    buttonArray[4].setTitle("A x B + C", for: .normal);
    buttonArray[5].setTitle("A - B x C", for: .normal);
    buttonArray[6].setTitle("A x B - C", for: .normal);
    buttonArray[7].setTitle("A x B x C", for: .normal);
    buttonArray[8].setTitle("A x B x inv(A)", for: .normal);
    
    stackView.axis = .vertical;
    stackView.distribution = .equalSpacing;
    stackView.alignment = .center;
    stackView.spacing = 4.0;
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    stackView.layoutMargins = UIEdgeInsets.init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0);
    stackView.isLayoutMarginsRelativeArrangement = true;
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.view.backgroundColor = .white
    self.view.addSubview(stackView)
    
    let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 44.0;
    let deviceWidth: CGFloat = UIScreen.main.bounds.size.width;
    let deviceHeight: CGFloat = UIScreen.main.bounds.size.height;
    stackView.widthAnchor.constraint(equalToConstant: deviceWidth).isActive = true;
    stackView.heightAnchor.constraint(equalToConstant: deviceHeight - navigationBarHeight).isActive = true;
  }
}
