//
//  UILabel+Extension.swift
//
//  Created by Yehya El Zein on 8/11/18.


import Foundation
import UIKit

extension UILabel{
    
    func SetupAlignment(){
        let isRTL = LocalRepository.GetCulture() == CULTURE.ARABIC.rawValue;
        self.textAlignment = isRTL ? .right : .left;
    }
    func Setup(_ text:String, isNumber:Bool = false){
        self.text = text;
        SetupAlignment();
    }
}
