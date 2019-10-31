//
//  ImageTextField.swift
//  Created by SaraAwad on 9/24/18.

import Foundation
import UIKit

@IBDesignable
class ImageTextField:UITextField{
    
    @IBInspectable var padding:CGFloat = 10{
        didSet{
            
        }
    }
    @IBInspectable var cornerRadius:CGFloat = 0 {
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
    
    @IBInspectable var innerImage:UIImage?{
        didSet{
            setImage();
        }
    }
    func setImage(){
        self.textAlignment = .left;
        let size:CGFloat = 20
        
        let imageV  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        if let image = innerImage{
            leftViewMode = .always
            
            let outerView = UIView(frame: CGRect(x: 0, y: 10, width: 40 , height: size) )
            outerView.backgroundColor = .clear
            
            imageV.image = innerImage?.withRenderingMode(.alwaysTemplate)
            imageV.tintColor = UIColor.lightGray
            outerView.addSubview(imageV)
            imageV.image = image
            leftView = outerView
        }else{
            leftViewMode = .never
        }
        
    }
    override func draw(_ rect: CGRect) {
        self.clearButtonMode = .never;  
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightBounds = super.rightViewRect(forBounds: bounds)
        rightBounds.origin.x-=3
        self.textAlignment = .right;
        return rightBounds
    }
}
