//
//  HeaderView.swift
//  LAApp
//
//  Created by Zhou Zhiyuan on 9/27/20.
//  Copyright © 2020 Zhou Zhiyuan. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame);
    self.text = "Welcome to LA App";
    self.textColor = UIColor.black;
    self.font = UIFont.preferredFont(forTextStyle: .headline);
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
  
