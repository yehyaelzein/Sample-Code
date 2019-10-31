//
//  UITextView + Extension.swift
//  Created by Yehya El Zein on 11/16/18.


import Foundation
import UIKit

extension UITextView{
    
    func GetNumberofLines() -> Int{
        if let fontUnwrapped = self.font{
            return Int(self.contentSize.height / fontUnwrapped.lineHeight)
        }
        return 0
    }
    
}
