//
//  MatrixCalculationInputViewController.swift
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
  var matrixCalculationType: CalculationType;
  var matrixInputView: UITextView = UITextView()
  var matrixInputViewHasValidInput = false
  var numberOfStepsNeededForInput: Int = 0
  var currentStepNumber: Int = 0
  var clearButton: UIButton = UIButton()
  var nextStepButton: UIButton = UIButton()
  var matrixA: Matrix = Matrix(entryArray: [[]])
  var matrixB: Matrix = Matrix(entryArray: [[]])
  var matrixC: Matrix = Matrix(entryArray: [[]])
  
  let matrixInputViewPlaceholderText = """
      Enter your matrix like this:
      1.2    2    -3
      3      4    1/2
      0.01   0    1
      """
  
  // MARK: init
  
  convenience init(type: CalculationType) {
    self.init(nibName:nil, bundle:nil, type: type)
  }
  
  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, type: CalculationType) {
    matrixCalculationType = type
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    UpdateSteps()
    setUpViews()
  }
  
  func setUpViews() {
    titleLabel.text = "Please Enter Matrix A"
    titleLabel.textColor = .black
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    titleLabel.sizeToFit()
    titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.size.width).isActive = true
    titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.frame.size.height).isActive = true
    
    vStackView.addArrangedSubview(titleLabel)
    
    matrixInputView.text = matrixInputViewPlaceholderText
    matrixInputView.backgroundColor = UIColor.init(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    matrixInputView.textColor = .darkGray
    matrixInputView.layer.cornerRadius = CGFloat(matrixInputCornerRadius);
    matrixInputView.isEditable = true
    matrixInputView.delegate = self
    matrixInputView.font = UIFont.systemFont(ofSize: 15.0)
    
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
    
    clearButton.setTitle("Clear", for: .normal)
    clearButton.backgroundColor = defaultColor
    
    clearButton.layer.cornerRadius = buttonCornerRadius
    clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
    
    nextStepButton.setTitle("Next", for: .normal)
    nextStepButton.backgroundColor = defaultColor
    nextStepButton.layer.cornerRadius = buttonCornerRadius
    nextStepButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    
    hStackView.addArrangedSubview(clearButton)
    hStackView.addArrangedSubview(nextStepButton)
    nextStepButton.leftAnchor.constraint(equalTo: clearButton.rightAnchor, constant: 4.0).isActive = true
    hStackView.axis = .horizontal
    hStackView.alignment = .center
    hStackView.distribution = .fillEqually
    hStackView.layoutMargins = UIEdgeInsets.init(top: 4.0, left: 16.0, bottom: 0.0, right: 16.0)
    hStackView.isLayoutMarginsRelativeArrangement = true
    hStackView.translatesAutoresizingMaskIntoConstraints = false
    
    vStackView.addArrangedSubview(hStackView)
    hStackView.topAnchor.constraint(equalTo: matrixInputView.bottomAnchor).isActive = true;
    hStackView.widthAnchor.constraint(equalTo: vStackView.widthAnchor).isActive = true
  }
  
  @objc func didTapClearButton() {
    matrixInputView.text = matrixInputViewPlaceholderText
    if (matrixInputView.isFirstResponder) {
      matrixInputView.resignFirstResponder()
    }
    matrixInputViewHasValidInput = false
  }
  
  @objc func didTapNextButton() {
    if (matrixInputView.isFirstResponder) {
      matrixInputView.resignFirstResponder()
    }
    verifyMatrixInputIsValid()
    
  }
  
  func verifyMatrixInputIsValid() {
    if (!MatrixInputVerificationHelpers.InputOnlyContainsSupportedSymbols(text: matrixInputView.text)) {
      let alertMessage = MatrixAlertHelper.AlertControllerWithMatrixInputAlertType(type: .ContainsInvalidCharacters)
      self.present(alertMessage, animated: true, completion: nil)
      return
    }
    
    if (!MatrixInputVerificationHelpers.InputContainsOnlyValidNumbers(text: matrixInputView.text)) {
      let alertMessage = MatrixAlertHelper.AlertControllerWithMatrixInputAlertType(type: .ContainsInvalidNumbers)
      self.present(alertMessage, animated: true, completion: nil)
    }
    
  }
  
  func registerCurrentMatrix() {
    
  }
  
  func updateContentForNextStep() {
    
  }
  
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: helper methods
  
  func TitleFromCalculationType(type: CalculationType) -> String {
    switch type {
      case .APlusB:
        return "A + B"
      case .AMinusB:
        return "A - B"
      case .ATimesB:
        return "A x B"
      case .APlusBTimesC:
        return "A + B x C"
      case .ATimesBPlusC:
        return "A x B + C"
      case .AMinusBTimesC:
        return "A - B x C"
      case .ATimesBMinusC:
        return "A x B - C"
      case .ATimesBTimesC:
        return "A x B x C"
      case .ATimesBTimesAInverse:
        return "A x B x inv(A)"
    }
  }
  
  func UpdateSteps() {
    currentStepNumber = 1;
    switch matrixCalculationType {
      case .APlusB:
        numberOfStepsNeededForInput = 2;
        break;
      case .AMinusB:
        numberOfStepsNeededForInput = 2;
        break;
      case .ATimesB:
        numberOfStepsNeededForInput = 2;
        break;
      case .APlusBTimesC:
        numberOfStepsNeededForInput = 3;
        break;
      case .ATimesBPlusC:
        numberOfStepsNeededForInput = 3;
        break;
      case .AMinusBTimesC:
        numberOfStepsNeededForInput = 3;
        break;
      case .ATimesBMinusC:
        numberOfStepsNeededForInput = 3;
        break;
      case .ATimesBTimesC:
        numberOfStepsNeededForInput = 3;
        break;
      case .ATimesBTimesAInverse:
        numberOfStepsNeededForInput = 2;
        break;
    }
  }
  
  // MARK: Lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationItem.title = TitleFromCalculationType(type:matrixCalculationType)
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
      textView.text = matrixInputViewPlaceholderText
      matrixInputViewHasValidInput = false
    } else {
      matrixInputViewHasValidInput = true
    }
  }
}
