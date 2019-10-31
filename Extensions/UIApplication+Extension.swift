//
//  UIApplication+Extension.swift
//
//  Created by Yehya El Zein on 8/13/18.

import Foundation
import UIKit

extension UIApplication{
    public func ShowNetworkIndicator(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
    }
    public func HideNetworkIndicator(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
    }
    
    class var topViewController: UIViewController? {
        return getTopViewController()
    }
    
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
