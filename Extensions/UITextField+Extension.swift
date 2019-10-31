//
//  UITextField+Extension.swift
//
//  Created by Yehya El Zein on 8/10/18.


import Foundation
import UIKit

extension UITextField{
    
    func SetupAlignment(){
        let isRTL = LocalRepository.GetCulture() == CULTURE.ARABIC.rawValue;
        self.textAlignment = isRTL ? .right : .left;
    }
    //MARK: Checks if the text field is empty or not
    public func IsTFEmpty() -> Bool{
        return TrimText().isEmpty
    }
    //MARK: Removes whitespaces and new lines from a string
    public func TrimText() -> String{
        return (self.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    func Setup(_ placeholder:String, isNumber:Bool = false){
       // self.placeholder = placeholder;
        self.keyboardType = isNumber ? .numberPad : .alphabet;
        SetupAlignment();
    }
}
