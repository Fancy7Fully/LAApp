//
//  MatrixManipulationViewController.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 10/12/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation
import UIKit

class MatrixManipulationLandingViewController : UIViewController {
  var buttonOne: UIButton = UIButton(); // A + B
  var buttonTwo: UIButton = UIButton(); // A - B
  var buttonThree: UIButton = UIButton(); // A x B
  var buttonFour: UIButton = UIButton(); // A + B x C
  var buttonFive: UIButton = UIButton(); // A x B + C
  var buttonSix: UIButton = UIButton(); // A - B x C
  var buttonSeven: UIButton = UIButton(); // A x B - C
  var buttonEight: UIButton = UIButton(); // A x B x C
  var buttonNine: UIButton = UIButton(); // A x B x A^(-1)
  var stackView: UIStackView = UIStackView();
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.navigationController?.setNavigationBarHidden(false, animated: false);
    buttonOne.setTitle("A + B", for: .normal);
    buttonTwo.setTitle("A - B", for: .normal);
//    buttonThree.setTitle("A x B", for: .normal);
//    buttonFour.setTitle("A + B x C", for: .normal);
//    buttonFive.setTitle("A x B + C", for: .normal);
//    buttonSix.setTitle("A - B x C", for: .normal);
//    buttonSeven.setTitle("A x B - C", for: .normal);
//    buttonEight.setTitle("A x B x C", for: .normal);
//    buttonNine.setTitle("A x B x inv(A)", for: .normal);
    buttonOne.heightAnchor.constraint(equalToConstant: 20.0).isActive = true;
    buttonTwo.heightAnchor.constraint(equalToConstant: 20.0).isActive = true;
    buttonOne.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonTwo.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    stackView.addArrangedSubview(buttonOne);
    stackView.addArrangedSubview(buttonTwo);
//    stackView.addArrangedSubview(buttonThree);
//    stackView.addArrangedSubview(buttonFour);
//    stackView.addArrangedSubview(buttonFive);
//    stackView.addArrangedSubview(buttonSix);
//    stackView.addArrangedSubview(buttonSeven);
//    stackView.addArrangedSubview(buttonEight);
//    stackView.addArrangedSubview(buttonNine);
    stackView.axis = .vertical;
    stackView.distribution = .fillEqually;
    stackView.alignment = .center;
    stackView.spacing = 4.0;
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    stackView.layoutMargins = UIEdgeInsets.init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0);
    stackView.isLayoutMarginsRelativeArrangement = true;
    
    self.view.addSubview(stackView);
    
    let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0;
    print(navigationBarHeight);
    let deviceWidth: CGFloat = UIScreen.main.bounds.size.width;
    let deviceHeight: CGFloat = UIScreen.main.bounds.size.height;
    stackView.widthAnchor.constraint(equalToConstant: deviceWidth).isActive = true;
    stackView.heightAnchor.constraint(equalToConstant: deviceHeight - navigationBarHeight).isActive = true;
//    stackView.
//    stackView.frame = CGRect.init(origin: CGPoint(x: 0, y: navigationBarHeight), size: CGSize(width: deviceWidth, height: deviceHeight - navigationBarHeight));
  }
  
  override func viewDidLayoutSubviews() {
//    buttonOne.sizeToFit();
//    buttonOne.frame = CGRect.init(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 50, height: 20));
//    buttonOne.backgroundColor = .red;
    
    stackView.sizeToFit();

    print(stackView.frame);
  }
}
