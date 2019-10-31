//
//  UIView+Extension.swift
//
//  Created by Yehya El Zein on 8/10/18.

import Foundation
import UIKit

public let kShapeDashed : String = "kShapeDashed"

extension UIView{
    
    func UpdateSemantics(){
        let IsRTL = LocalRepository.GetCulture() == CULTURE.ARABIC.rawValue;
        self.semanticContentAttribute = IsRTL ? .forceRightToLeft : .forceLeftToRight;
    }
    func UpdateDeviceSemantics(){
        let IsRTL = LocalRepository.GetCulture() == CULTURE.ARABIC.rawValue;
        let IsPhoneRTL = Locale.current.languageCode! == CULTURE.ARABIC.rawValue ? true : false
        self.semanticContentAttribute = IsPhoneRTL ? .forceLeftToRight : (IsRTL ? .forceRightToLeft : .forceLeftToRight);
    }
    
    
    func DrawDottedLine() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3]
        
        let path = CGMutablePath()
        let startingPoint = CGPoint(x: self.bounds.minX, y: self.bounds.minY);
        let endingPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.maxY);
        print("s point \(startingPoint)")
        print("end point \(endingPoint)")
        path.addLines(between: [startingPoint, endingPoint])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    func addDashedBorder(width: CGFloat? = nil, height: CGFloat? = nil, lineWidth: CGFloat = 2, lineDashPattern:[NSNumber]? = [6,3], strokeColor: UIColor = UIColor.red, fillColor: UIColor = UIColor.clear) {
        
        self.layoutIfNeeded();
        var fWidth: CGFloat? = width
        var fHeight: CGFloat? = height
        
        if fWidth == nil {
            fWidth = self.frame.width
        }
        
        if fHeight == nil {
            fHeight = self.frame.height
        }
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        
        let shapeRect = CGRect(x: 0, y: 0, width: fWidth!, height: fHeight!)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: fWidth!/2, y: fHeight!/2)
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = lineDashPattern
        shapeLayer.name = kShapeDashed
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}

 
