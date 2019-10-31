//
//  RadioButton.swift
//  Created by SaraAwad on 10/19/18.

import Foundation
import UIKit

public class RadioButton: UIView{
    var isChecked = false
    var radioTintColor = Constants.DEFAULT_APP_COLOR;
    var radioView = UIView()
    
    func initialize(tntColor: UIColor = Constants.DEFAULT_APP_COLOR) {
        self.isChecked = false
        self.radioTintColor = tntColor
        SetupRadioView()
    }
    public func SetupRadioView(){
        self.addSubview(radioView)
        radioView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.equalTo(self).offset(-20)
            make.width.equalTo(self).offset(-20)
        }
        self.layoutIfNeeded()
        radioView.backgroundColor = self.radioTintColor
        radioView.layer.cornerRadius = radioView.frame.size.width / 2
        radioView.layer.opacity = 0
    }
    public func ToggleCheck(){
        if self.isChecked{
            Uncheck()
        }else{
            Check()
        }
    }
    public func Check(){
        isChecked = true
        self.layer.borderColor = Constants.DEFAULT_APP_COLOR.cgColor
        UIView.animate(withDuration: 0.1, animations: {
            self.radioView.layer.opacity = 1.0
        })
    }
    public func Uncheck(){
        self.layer.borderColor = Constants.DEFAULT_APP_COLOR.cgColor
        isChecked = false
        UIView.animate(withDuration: 0.1, animations: {
            self.radioView.layer.opacity = 0.0
        })
    }
}
