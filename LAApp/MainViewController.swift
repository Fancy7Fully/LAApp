//
//  ViewController.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 9/27/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import UIKit
import QuartzCore

let kTopInset: CGFloat = 100.0;
let kButtonsTopInset: CGFloat = 100.0;

class MainViewController: UIViewController {
  var headerLabel: UILabel = HeaderView.init(frame: CGRect.zero);
  var matrixManipulationButton: UIButton = UIButton.init(frame: CGRect.zero);
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: false);
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.setNavigationBarHidden(true, animated: false);
    setupButtons();
    self.view.backgroundColor = UIColor.white;
    self.view.addSubview(self.headerLabel);
    self.view.addSubview(self.matrixManipulationButton);
  }
  
  override func viewDidLayoutSubviews() {
    self.headerLabel.sizeToFit();
    self.headerLabel.frame = CGRect.init(
      x: calculateX(self.view.bounds.size.width, self.headerLabel.frame.size.width),
      y: kTopInset,
      width: self.headerLabel.frame.size.width,
      height: self.headerLabel.frame.size.height);
    
    self.matrixManipulationButton.sizeToFit();
    self.matrixManipulationButton.frame = CGRect.init(
      x: calculateX(self.view.bounds.size.width, self.matrixManipulationButton.frame.size.width + 20),
      y: kTopInset + kButtonsTopInset,
      width: self.matrixManipulationButton.frame.size.width + 20,
      height: self.matrixManipulationButton.frame.size.height + 10);
    self.matrixManipulationButton.layer.cornerRadius = 10.0;
    self.matrixManipulationButton.clipsToBounds = true;
    
    self.matrixManipulationButton.addTarget(
      self,
      action: #selector(didTapMatrixManipulationButton),
      for: UIControl.Event.touchUpInside);
  }
  
  @objc func didTapMatrixManipulationButton() {
    let controller : UIViewController = MatrixManipulationViewController();
    
    self.navigationController?.pushViewController(controller, animated: true);
  }
  
  private func setupButtons() {
    self.matrixManipulationButton.setTitle("Matrix calculation", for: UIControl.State.normal);
    self.matrixManipulationButton.backgroundColor = UIColor.init(displayP3Red: 0.0, green: 140.0/255.0, blue: 174.0/255.0, alpha: 1.0);
    self.matrixManipulationButton.setTitleColor(UIColor.white, for: UIControl.State.normal);
  }
  
  private func calculateX(_ screenWidth: CGFloat, _ viewWidth: CGFloat) -> CGFloat {
    return (screenWidth - viewWidth) / 2;
  }

}

