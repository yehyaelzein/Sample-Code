//
//  CircularProgressView.swift
//  Created by SaraAwad on 8/25/18.

import Foundation
import UIKit
import SnapKit

class CircularProgressView:UIView, CAAnimationDelegate{
    var innerShapeLayer = CAShapeLayer();
    var RADIUS:CGFloat = 15
    var percentLB = UILabel();
    var toValue = Double();
    var downloadIcon = UIImageView();
    var counter = 0.25;
    var isFileLocal = false;
    var size:CGFloat = 30;
    
    //MARK: Design
    func Init(isFileLocal:Bool){
        self.layoutIfNeeded()
        RADIUS = self.frame.height * 0.5
        self.isFileLocal = isFileLocal;
        CheckIfFileExists();
    }
    
     func InitDownload(imageName: String){
        downloadIcon.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate);
        downloadIcon.tintColor = UIColor.darkGray;
        downloadIcon.contentMode = .scaleAspectFit;
        downloadIcon.layer.zPosition = 3;
        downloadIcon.tag = imageName ==  "" ? 1 : 2;
        self.addSubview(downloadIcon);
        downloadIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(30);
            make.height.equalTo(30);
        }

        percentLB.font = UIFont(name: Constants.DEFAULT_FONT, size: 8);
        percentLB.textColor = Constants.RED_COLOR;
        percentLB.text = "";
        self.addSubview(percentLB);
        percentLB.snp.makeConstraints { (make) in
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(15);
        }
    }
    private func DrawCircularProgress(radius:CGFloat, strokeEnd: CGFloat, strokeColor:CGColor, lineWidth: CGFloat, fillColor:CGColor)->CAShapeLayer{
        let point = CGPoint(x: self.frame.width - RADIUS, y: self.frame.height - RADIUS);
        let circularPath = UIBezierPath(arcCenter: point, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true);
        let shapeLayer = CAShapeLayer();
        shapeLayer.path = circularPath.cgPath;
        shapeLayer.strokeColor = strokeColor;
        shapeLayer.lineWidth = lineWidth;
        shapeLayer.strokeEnd = strokeEnd;
        shapeLayer.lineCap = CAShapeLayerLineCap.round;
        shapeLayer.fillColor = fillColor;
        shapeLayer.accessibilityValue = "circle";
        self.layer.addSublayer(shapeLayer);
        return shapeLayer;
    }
    func InitBackgroundCircle(){
        _ = DrawCircularProgress(radius: RADIUS, strokeEnd: 1, strokeColor: UIColor.lightGray.cgColor, lineWidth: 0.5, fillColor: UIColor.clear.cgColor);
        _ = DrawCircularProgress(radius: RADIUS - 2, strokeEnd: 1, strokeColor: UIColor.lightGray.cgColor, lineWidth: 0.5, fillColor: UIColor.clear.cgColor);
    }
    func InitInnerCircle(){
       innerShapeLayer = DrawCircularProgress(radius: (RADIUS + (RADIUS - 2)) / 2, strokeEnd: 0, strokeColor: Constants.RED_COLOR.cgColor, lineWidth: 5, fillColor: UIColor.clear.cgColor);
    }
    
    //MARK: Actions
    func CheckIfFileExists(){
        InitDownload(imageName: isFileLocal ? "" : "ic_download");
    }
    func UpdateProgress(progress:Double, toValue:Double){
        downloadIcon.image = UIImage(named: "");
        self.toValue = toValue;
        if progress <= 100 {
            percentLB.text = String(format: "%@%@", String(Int(progress)), "%");
        }
        if ceil(progress) == 10 || ceil(progress) == 25 || ceil(progress) == 55 || ceil(progress) == 100{
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd");
            basicAnimation.fromValue = 0;
            basicAnimation.toValue = 1;
            basicAnimation.duration = 2;
            basicAnimation.fillMode = CAMediaTimingFillMode.both;
            basicAnimation.isRemovedOnCompletion = false;
            basicAnimation.delegate = self;
            basicAnimation.repeatCount = 100;
            innerShapeLayer.add(basicAnimation, forKey: "strokeAnimation");
        }
        if progress == 100{
            self.EndProgress();
        }
    }
    @objc func DownloadBegin(_ sender:UIGestureRecognizer?){
        InitBackgroundCircle();
        InitInnerCircle();
        downloadIcon.image = UIImage(named: "")?.withRenderingMode(.alwaysTemplate);
        downloadIcon.tintColor = UIColor.darkGray;
    }
    @objc func tapCircle(_ sender:UIGestureRecognizer?){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd");
        basicAnimation.fromValue = 0;
        basicAnimation.toValue = toValue;
        basicAnimation.duration = 200;
        basicAnimation.fillMode = CAMediaTimingFillMode.both;
        basicAnimation.isRemovedOnCompletion = false;
        basicAnimation.delegate = self;
        innerShapeLayer.add(basicAnimation, forKey: "strokeAnimation");
    }
    func animationDidStart(_ anim: CAAnimation) {
    }
    func EndProgress(){
        self.percentLB.text = "";
        self.layer.sublayers?.forEach({
            if $0.accessibilityValue == "circle"{
                $0.removeFromSuperlayer()
            }
        });
        self.downloadIcon.image = UIImage(named: "");
    }

}


