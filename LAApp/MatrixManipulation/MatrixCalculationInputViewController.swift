//
//  File.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 10/30/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation
import UIKit

let matrixInputCornerRadius = 10.0

class MatrixCalculationInputViewController : UIViewController, UITextViewDelegate {
  var vStackView: UIStackView = UIStackView()
  var hStackView: UIStackView = UIStackView()
  var titleLabel: UILabel = UILabel()
  var matrixCalculationType: calculationType;
  var matrixInputView: UITextView = UITextView()
  var matrixInputViewHasValidInput = false
  
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
    titleLabel.sizeToFit()
    titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.size.width).isActive = true
    titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.frame.size.height).isActive = true
    
    vStackView.addArrangedSubview(titleLabel)
    
    matrixInputView.text = """
    Enter your matrix like:
    1 2 3
    4 5 6
    7 8 9
    """
    matrixInputView.backgroundColor = .lightGray
    matrixInputView.textColor = .darkGray
    matrixInputView.layer.cornerRadius = CGFloat(matrixInputCornerRadius);
    matrixInputView.isEditable = true
    matrixInputView.delegate = self
    
    matrixInputView.widthAnchor.constraint(equalToConstant: 200).isActive = true;
    matrixInputView.heightAnchor.constraint(equalToConstant: 120).isActive = true;
    matrixInputView.keyboardType = .numbersAndPunctuation
    
    vStackView.addArrangedSubview(matrixInputView);
    vStackView.axis = .vertical
//    vStackView.distribution = .equalCentering
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
    
//    let navigationBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 44.0;
    let deviceWidth: CGFloat = UIScreen.main.bounds.size.width;
//    let deviceHeight: CGFloat = UIScreen.main.bounds.size.height;
    vStackView.widthAnchor.constraint(equalToConstant: deviceWidth).isActive = true;
//    vStackView.heightAnchor.constraint(equalToConstant: deviceHeight - navigationBarHeight).isActive = true;
    let touchDownEvent = UITapGestureRecognizer(target: self, action: #selector(self.didTouchOutside(_:)))
    self.view.addGestureRecognizer(touchDownEvent)
    
  }
  
  @objc func didTouchOutside(_ sender: UITapGestureRecognizer) {
    if (matrixInputView.isFirstResponder) {
      matrixInputView.resignFirstResponder()
    }
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.becomeFirstResponder()
    if (!matrixInputViewHasValidInput) {
      textView.text = ""
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    let currentText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
    if (currentText.count == 0) {
      textView.text = """
      Enter your matrix like:
      1 2 3
      4 5 6
      7 8 9
      """
      matrixInputViewHasValidInput = false
    } else {
      matrixInputViewHasValidInput = true
    }
  }
}
