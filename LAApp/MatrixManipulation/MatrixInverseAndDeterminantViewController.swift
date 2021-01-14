//
//  MatrixInverseAndRankViewController.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 1/13/21.
//  Copyright © 2021 Zhou Zhiyuan. All rights reserved.
//

import Foundation
import UIKit

class MatirxInverseAndRankViewController : UIViewController, UITextViewDelegate {
  var vStackView: UIStackView = UIStackView()
  var titleLabel: UILabel = UILabel()
  var matrixInputView: UITextView = UITextView()
  var matrixInputViewHasInput = false
  var clearButton: UIButton = UIButton()
  var findDeterminantButton: UIButton = UIButton()
  var findInverseButton: UIButton = UIButton()
  var rank: Int = -1
  var rankLabel: UILabel = UILabel()
  
  let matrixInputViewPlaceholderText = """
      Enter your matrix like this:
      1/2    2    -3
      3/4    4    1/2
      -1/3   0    1
      """
  
  // MARK: init
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setUpViews()
  }
  
  func setUpViews() {
    titleLabel.text = "Please Enter A Matrix"
    titleLabel.textColor = .black
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    titleLabel.sizeToFit()
    titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: titleLabel.frame.size.width).isActive = true
    titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: titleLabel.frame.size.height).isActive = true
    
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
    vStackView.alignment = .center
    vStackView.spacing = 4.0
    vStackView.translatesAutoresizingMaskIntoConstraints = false
    vStackView.layoutMargins = UIEdgeInsets.init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0);
    vStackView.isLayoutMarginsRelativeArrangement = true;
    
    clearButton.setTitle("Clear", for: .normal)
    clearButton.backgroundColor = defaultColor
    
    clearButton.layer.cornerRadius = buttonCornerRadius
    clearButton.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
    
    findDeterminantButton.setTitle("Find Determinant", for: .normal)
    findDeterminantButton.backgroundColor = defaultColor
    findDeterminantButton.layer.cornerRadius = buttonCornerRadius
    findDeterminantButton.addTarget(self, action: #selector(didTapFindDeterminantButton), for: .touchUpInside)
    
    findInverseButton.setTitle("Find Iverse", for: .normal)
    findInverseButton.backgroundColor = defaultColor
    findInverseButton.layer.cornerRadius = buttonCornerRadius
    findInverseButton.addTarget(self, action: #selector(didTapFindInverseButton), for: .touchUpInside)
    clearButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
    findDeterminantButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
    findInverseButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
    
    vStackView.addArrangedSubview(clearButton)
    vStackView.addArrangedSubview(findDeterminantButton)
    vStackView.addArrangedSubview(findInverseButton)
    
    rankLabel.isHidden = true
  }
  
  @objc func didTapClearButton() {
    matrixInputView.text = matrixInputViewPlaceholderText
    matrixInputView.textColor = .darkGray
    if (matrixInputView.isFirstResponder) {
      matrixInputView.resignFirstResponder()
    }
    matrixInputViewHasInput = false
  }
  
  @objc func didTapFindDeterminantButton() {
    if (matrixInputView.isFirstResponder) {
      matrixInputView.resignFirstResponder()
    }
    if (matrixInputView.text.count == 0 || !matrixInputViewHasInput) {
      return
    }
    verifyMatrixInputIsValid()
    let matrix = MatrixInputHelpers.ParseInput(text: matrixInputView.text)
    presentDeterminant(matrix: matrix)
  }
  
  @objc func didTapFindInverseButton() {

  }
  
  func updateViewWithResult(result: Matrix) {
    matrixInputView.text = MatrixInputHelpers.TextFromMatrix(matrix: result)
    vStackView.removeArrangedSubview(titleLabel)
    
    titleLabel.text = "Calculation Result"
    titleLabel.sizeToFit()
    titleLabel.removeConstraints(titleLabel.constraints)
    titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.size.width).isActive = true
    titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: titleLabel.frame.size.height).isActive = true
    vStackView.insertArrangedSubview(titleLabel, at: 0)
  }
  
  func updateMatrixInputViewWithMatrix(matrix: Matrix) {
    matrixInputView.text = MatrixInputHelpers.TextFromMatrix(matrix: matrix)
    matrixInputViewHasInput = true
  }
  
  func verifyMatrixInputIsValid() {
    if (!matrixInputViewHasInput) {
      presentAlertWithType(type: .EmptyInput)
      return
    }
    
    if (!MatrixInputHelpers.InputOnlyContainsSupportedSymbols(text: matrixInputView.text)) {
      presentAlertWithType(type: .ContainsInvalidCharacters)
      return
    }
    
    if (!MatrixInputHelpers.InputContainsOnlyValidNumbers(text: matrixInputView.text)) {
      presentAlertWithType(type: .ContainsInvalidNumbers)
    }
    
    if (!MatrixInputHelpers.VerifyEntryNumberIsSameAcrossRows(text: matrixInputView.text)) {
      presentAlertWithType(type: .DifferentNumberOfEntries)
    }
  }
  
  func findRank() -> Int {
    let matrix = MatrixInputHelpers.ParseInput(text: matrixInputView.text)
    let ref = MatrixUtils.REF(matrix: matrix)
    var count = 0
    for i in 0..<ref.rowNumber {
      var allZero = true
      for j in 0..<ref.colNumber {
        if (ref.entries[i][j].floatValue() != 0.0) {
          count = count + 1
          allZero = false
          break
        }
      }
      if (allZero) {
        break
      }
    }
    
    return count
  }
  
  func presentDeterminant(matrix: Matrix) {
    rankLabel.text = "The determinant is : " + String(matrix.determinant.numerator) + "/" + String(matrix.determinant.denominator)
    rankLabel.sizeToFit()
    rankLabel.removeConstraints(rankLabel.constraints)
    rankLabel.widthAnchor.constraint(equalToConstant: rankLabel.frame.size.width).isActive = true
    rankLabel.heightAnchor.constraint(equalToConstant: rankLabel.frame.size.height).isActive = true
    rankLabel.isHidden = false
    vStackView.addArrangedSubview(rankLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: helper methods
  
  func presentAlertWithType(type: MatrixInputAlertType) {
    let alertMessage = MatrixAlertHelper.AlertControllerWithMatrixInputAlertType(type: type)
    self.present(alertMessage, animated: true, completion: nil)
  }
  
  // MARK: Lifecycle methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationItem.title = "Inverse and Rank"
    self.view.backgroundColor = .white
    self.view.addSubview(vStackView)
    
    let deviceWidth: CGFloat = UIScreen.main.bounds.size.width;
    vStackView.widthAnchor.constraint(equalToConstant: deviceWidth).isActive = true;
    let touchDownEvent = UITapGestureRecognizer(target: self, action: #selector(didTouchOutside(_:)))
    self.view.addGestureRecognizer(touchDownEvent)
    
  }
  
  @objc func didTouchOutside(_ sender: UITapGestureRecognizer) {
    if (matrixInputView.isFirstResponder) {
      matrixInputView.resignFirstResponder()
    }
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.becomeFirstResponder()
    if (!matrixInputViewHasInput) {
      textView.text = ""
      matrixInputView.textColor = .black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    let currentText = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
    if (currentText.count == 0) {
      textView.text = matrixInputViewPlaceholderText
      matrixInputViewHasInput = false
      matrixInputView.textColor = .darkGray
    } else {
      matrixInputViewHasInput = true
    }
  }
}
