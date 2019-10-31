//
//  RoundedButton.swift
//  Created by SaraAwad on 9/24/18.

import Foundation
import UIKit

@IBDesignable
class RoundedButton:UIButton{
  
    @IBInspectable var cornerRadius:CGFloat = 5 {
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth:CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
}
