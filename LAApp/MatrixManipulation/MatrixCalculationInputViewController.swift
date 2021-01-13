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
  var matrixInputViewHasInput = false
  var numberOfStepsNeededForInput: Int = 0
  var currentStepNumber: Int = 0
  var clearButton: UIButton = UIButton()
  var nextStepButton: UIButton = UIButton()
  var backButton: UIButton = UIButton()
  var matrixA: Matrix = Matrix(entryArray: [[]])
  var matrixB: Matrix = Matrix(entryArray: [[]])
  var matrixC: Matrix = Matrix(entryArray: [[]])
  
  let matrixInputViewPlaceholderText = """
      Enter your matrix like this:
      1/2    2    -3
      3/4    4    1/2
      -1/3   0    1
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
    
    nextStepButton.setTitle("Next", for: .normal)
    nextStepButton.backgroundColor = defaultColor
    nextStepButton.layer.cornerRadius = buttonCornerRadius
    nextStepButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    
    backButton.setTitle("Back", for: .normal)
    backButton.backgroundColor = defaultColor
    backButton.layer.cornerRadius = buttonCornerRadius
    backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    backButton.isHidden = true
    
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
    vStackView.addArrangedSubview(backButton)
  }
  
  @objc func didTapClearButton() {
    matrixInputView.text = matrixInputViewPlaceholderText
    matrixInputView.textColor = .darkGray
    if (matrixInputView.isFirstResponder) {
      matrixInputView.resignFirstResponder()
    }
    matrixInputViewHasInput = false
  }
  
  @objc func didTapNextButton() {
    if (matrixInputView.isFirstResponder) {
      matrixInputView.resignFirstResponder()
    }
    if (matrixInputView.text.count == 0 || !matrixInputViewHasInput) {
      return
    }
    verifyMatrixInputIsValid()
    registerCurrentMatrix()
    updateContentForNextStep()
  }
  
  @objc func didTapBackButton() {
    currentStepNumber = currentStepNumber - 1;
    vStackView.removeArrangedSubview(titleLabel)
    
    if (currentStepNumber == 1) {
      updateMatrixInputViewWithMatrix(matrix: matrixA)
      titleLabel.text = "Please Enter Matrix A"
      backButton.isHidden = true
    } else if (currentStepNumber == 2) {
      updateMatrixInputViewWithMatrix(matrix: matrixB)
      titleLabel.text = "Please Enter Matrix B"
    }
    
    titleLabel.sizeToFit()
    titleLabel.removeConstraints(titleLabel.constraints)
    titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.size.width).isActive = true
    titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: titleLabel.frame.size.height).isActive = true
    vStackView.insertArrangedSubview(titleLabel, at: 0)
    
    if (hStackView.isHidden) {
      hStackView.isHidden = false
    }
    nextStepButton.setTitle("Next", for: .normal)
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
    hStackView.isHidden = true
  }
  
  func calculateAndPresentResult() {
    switch matrixCalculationType {
    case .APlusB:
      do {
        let result =
          try MatrixUtils.Sum(a: matrixA, b: matrixB)
        updateViewWithResult(result: result)
      } catch MatrixUtilError.emptyMatrix {
        presentAlertWithType(type: .EmptyInput)
      } catch MatrixUtilError.unsupportedCalculation {
        presentAlertWithType(type: .UnableToCalculate)
      } catch {
        return
      }
      break;
    case .AMinusB:
      do {
        let result =
          try MatrixUtils.Difference(a: matrixA, b: matrixB)
        updateViewWithResult(result: result)
      } catch MatrixUtilError.emptyMatrix {
        presentAlertWithType(type: .EmptyInput)
      } catch MatrixUtilError.unsupportedCalculation {
        presentAlertWithType(type: .UnableToCalculate)
      } catch {
        return
      }
      break;
    case .ATimesB:
      do {
        let result =
          try MatrixUtils.Product(a: matrixA, b: matrixB)
        updateViewWithResult(result: result)
      } catch MatrixUtilError.emptyMatrix {
        presentAlertWithType(type: .EmptyInput)
      } catch MatrixUtilError.unsupportedCalculation {
        presentAlertWithType(type: .UnableToCalculate)
      } catch {
        return
      }
      break;
    case .ATimesBPlusC:
      do {
        var result =
          try MatrixUtils.Product(a: matrixA, b: matrixB)
        result = try MatrixUtils.Sum(a: result, b: matrixC)
        updateViewWithResult(result: result)
      } catch MatrixUtilError.emptyMatrix {
        presentAlertWithType(type: .EmptyInput)
      } catch MatrixUtilError.unsupportedCalculation {
        presentAlertWithType(type: .UnableToCalculate)
      } catch {
        return
      }
      break;
    case .ATimesBMinusC:
      do {
        var result =
          try MatrixUtils.Product(a: matrixA, b: matrixB)
        result = try MatrixUtils.Difference(a: result, b: matrixC)
        updateViewWithResult(result: result)
      } catch MatrixUtilError.emptyMatrix {
        presentAlertWithType(type: .EmptyInput)
      } catch MatrixUtilError.unsupportedCalculation {
        presentAlertWithType(type: .UnableToCalculate)
      } catch {
        return
      }
      break;
    case .APlusBTimesC:
      do {
        var result =
          try MatrixUtils.Product(a: matrixB, b: matrixC)
        result = try MatrixUtils.Sum(a: matrixA, b: result)
        updateViewWithResult(result: result)
      } catch MatrixUtilError.emptyMatrix {
        presentAlertWithType(type: .EmptyInput)
      } catch MatrixUtilError.unsupportedCalculation {
        presentAlertWithType(type: .UnableToCalculate)
      } catch {
        return
      }
      break;
    case .AMinusBTimesC:
      do {
        var result =
          try MatrixUtils.Product(a: matrixB, b: matrixC)
        result = try MatrixUtils.Difference(a: matrixA, b: result)
        updateViewWithResult(result: result)
      } catch MatrixUtilError.emptyMatrix {
        presentAlertWithType(type: .EmptyInput)
      } catch MatrixUtilError.unsupportedCalculation {
        presentAlertWithType(type: .UnableToCalculate)
      } catch {
        return
      }
      break;
    case .ATimesBTimesC:
      do {
        var result =
          try MatrixUtils.Product(a: matrixA, b: matrixB)
        result = try MatrixUtils.Product(a: result, b: matrixC)
        updateViewWithResult(result: result)
      } catch MatrixUtilError.emptyMatrix {
        presentAlertWithType(type: .EmptyInput)
      } catch MatrixUtilError.unsupportedCalculation {
        presentAlertWithType(type: .UnableToCalculate)
      } catch {
        return
      }
      break;
    case .ATimesBTimesAInverse:
      return
    }
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
  
  func registerCurrentMatrix() {
    if (currentStepNumber == 1) {
      matrixA = MatrixInputHelpers.ParseInput(text: matrixInputView.text)
    } else if (currentStepNumber == 2) {
      matrixB = MatrixInputHelpers.ParseInput(text: matrixInputView.text)
      
    } else if (currentStepNumber == 3) {
      matrixC = MatrixInputHelpers.ParseInput(text: matrixInputView.text)
    }
  }
  
  func updateContentForNextStep() {
    currentStepNumber = currentStepNumber + 1
    if (currentStepNumber > numberOfStepsNeededForInput) {
      calculateAndPresentResult()
      return
    }
    
    if (currentStepNumber == numberOfStepsNeededForInput) {
      nextStepButton.setTitle("Calculate", for: .normal)
    }
    matrixInputView.text = matrixInputViewPlaceholderText
    matrixInputView.textColor = .darkGray
    if (currentStepNumber == 2) {
      titleLabel.text = "Please Enter Matrix B"
    } else if (currentStepNumber == 3) {
      titleLabel.text = "Please Enter Matrix C"
    }
    
    vStackView.removeArrangedSubview(titleLabel)
    
    titleLabel.sizeToFit()
    titleLabel.removeConstraints(titleLabel.constraints)
    titleLabel.widthAnchor.constraint(equalToConstant: titleLabel.frame.size.width).isActive = true
    titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: titleLabel.frame.size.height).isActive = true
    vStackView.insertArrangedSubview(titleLabel, at: 0)
    
    matrixInputViewHasInput = false
    if backButton.isHidden {
      backButton.isHidden = false
      backButton.widthAnchor.constraint(equalToConstant: clearButton.frame.size.width).isActive = true
      backButton.heightAnchor.constraint(equalToConstant: clearButton.frame.size.height).isActive = true
    }
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
        return "A \u{00D7} B"
      case .APlusBTimesC:
        return "A + B \u{00D7} C"
      case .ATimesBPlusC:
        return "A \u{00D7} B + C"
      case .AMinusBTimesC:
        return "A - B \u{00D7} C"
      case .ATimesBMinusC:
        return "A \u{00D7} B - C"
      case .ATimesBTimesC:
        return "A \u{00D7} B \u{00D7} C"
      case .ATimesBTimesAInverse:
        return "A \u{00D7} B \u{00D7} inv(A)"
    }
  }
  
  func presentAlertWithType(type: MatrixInputAlertType) {
    let alertMessage = MatrixAlertHelper.AlertControllerWithMatrixInputAlertType(type: type)
    self.present(alertMessage, animated: true, completion: nil)
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
    
    let deviceWidth: CGFloat = UIScreen.main.bounds.size.width;
    vStackView.widthAnchor.constraint(equalToConstant: deviceWidth).isActive = true;
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
