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

class MatrixManipulationLandingViewController : UIViewController {
  var buttonOne: UIButton = UIButton(); // A + B
  var buttonTwo: UIButton = UIButton(); // A - B
  var buttonThree: UIButton = UIButton(); // A x B
  var buttonFour: UIButton = UIButton(); // A + B x C
  var buttonFive: UIButton = UIButton(); // A x B + C
  var buttonSix: UIButton = UIButton(); // A - B x C
  var buttonSeven: UIButton = UIButton(); // A x B - C
  var buttonEight: UIButton = UIButton(); // A x B x C
  var buttonNine: UIButton = UIButton(); // A x B x inv(A)
  var buttonTen: UIButton = UIButton(); // inv(A)
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
 
    buttonOne.setTitle("A + B", for: .normal);
    buttonTwo.setTitle("A - B", for: .normal);
    buttonThree.setTitle("A x B", for: .normal);
    buttonFour.setTitle("A + B x C", for: .normal);
    buttonFive.setTitle("A x B + C", for: .normal);
    buttonSix.setTitle("A - B x C", for: .normal);
    buttonSeven.setTitle("A x B - C", for: .normal);
    buttonEight.setTitle("A x B x C", for: .normal);
    buttonNine.setTitle("A x B x inv(A)", for: .normal);
    buttonTen.setTitle("inv(A)", for: .normal);
    
    buttonOne.backgroundColor = defaultColor;
    buttonTwo.backgroundColor = defaultColor;
    buttonThree.backgroundColor = defaultColor;
    buttonFour.backgroundColor = defaultColor;
    buttonFive.backgroundColor = defaultColor;
    buttonSix.backgroundColor = defaultColor;
    buttonSeven.backgroundColor = defaultColor;
    buttonEight.backgroundColor = defaultColor;
    buttonNine.backgroundColor = defaultColor;
    buttonTen.backgroundColor = defaultColor;
    
    buttonOne.layer.cornerRadius = 10.0;
    buttonTwo.layer.cornerRadius = 10.0;
    buttonThree.layer.cornerRadius = 10.0;
    buttonFour.layer.cornerRadius = 10.0;
    buttonFive.layer.cornerRadius = 10.0;
    buttonSix.layer.cornerRadius = 10.0;
    buttonSeven.layer.cornerRadius = 10.0;
    buttonEight.layer.cornerRadius = 10.0;
    buttonNine.layer.cornerRadius = 10.0;
    buttonTen.layer.cornerRadius = 10.0;
    
    buttonOne.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonTwo.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonThree.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonFour.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonFive.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonSix.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonSeven.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonEight.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonNine.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    buttonTen.widthAnchor.constraint(equalToConstant: 120.0).isActive = true;
    
    stackView.addArrangedSubview(titleLabel);
    stackView.addArrangedSubview(buttonOne);
    stackView.addArrangedSubview(buttonTwo);
    stackView.addArrangedSubview(buttonThree);
    stackView.addArrangedSubview(buttonFour);
    stackView.addArrangedSubview(buttonFive);
    stackView.addArrangedSubview(buttonSix);
    stackView.addArrangedSubview(buttonSeven);
    stackView.addArrangedSubview(buttonEight);
    stackView.addArrangedSubview(buttonNine);
    stackView.addArrangedSubview(buttonTen);
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
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    self.navigationController?.setNavigationBarHidden(false, animated: false);
    self.view.backgroundColor = .white;
    self.view.addSubview(stackView);
    
    let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0;
    print(navigationBarHeight);
    let deviceWidth: CGFloat = UIScreen.main.bounds.size.width;
    let deviceHeight: CGFloat = UIScreen.main.bounds.size.height;
    stackView.widthAnchor.constraint(equalToConstant: deviceWidth).isActive = true;
    stackView.heightAnchor.constraint(equalToConstant: deviceHeight - navigationBarHeight).isActive = true;
  }
}
