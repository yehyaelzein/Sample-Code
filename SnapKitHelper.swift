
import Foundation
import UIKit
import SnapKit


public class SnapKitHelper{
    
    public static func GetSafeAreaTop(parentViewController:UIViewController)->ConstraintItem{
        if #available(iOS 11.0, *) {
            return parentViewController.view.safeAreaLayoutGuide.snp.top
        } else {
            return parentViewController.topLayoutGuide.snp.bottom
        }
    }
    public static func GetSafeAreaBottom(parentViewController:UIViewController)->ConstraintItem{
        if #available(iOS 11.0, *) {
            return parentViewController.view.safeAreaLayoutGuide.snp.bottom
        } else {
            return parentViewController.view.snp.bottomMargin
        }
    }
    public static func GetSafeAreaLeading(parentViewController:UIViewController)->ConstraintItem{
        if #available(iOS 11.0, *) {
            return parentViewController.view.safeAreaLayoutGuide.snp.leading
        } else {
            return parentViewController.view.snp.leading
        }
    }
    public static func GetSafeAreaTrailing(parentViewController:UIViewController)->ConstraintItem{
        if #available(iOS 11.0, *) {
            return parentViewController.view.safeAreaLayoutGuide.snp.trailing
        } else {
            return parentViewController.view.snp.trailing
        }
    }
    public static func GetSafeAreaWidth(parentViewController:UIViewController)->ConstraintItem{
        if #available(iOS 11.0, *) {
            return parentViewController.view.safeAreaLayoutGuide.snp.width
        } else {
            return parentViewController.view.snp.width
        }
    }
    public static func GetSafeAreaHeight(parentViewController:UIViewController)->ConstraintItem{
        if #available(iOS 11.0, *) {
            return parentViewController.view.safeAreaLayoutGuide.snp.height
        } else {
            return parentViewController.view.snp.height
        }
    }
}
