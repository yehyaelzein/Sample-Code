//
//  UIImageView+Extension.swift
//  Created by Yehya El Zein on 9/28/18.


import Foundation
import UIKit

extension UIImageView{
    
    func LoadImageURLFromServer(_ urlString:String,  _ defaultImage:String?, cornerRadius:CGFloat = 0){
        print("urlString \(urlString)")
        if let defaultImage = defaultImage{
                self.image = UIImage(named: defaultImage)
                return;
        }
        if let url = NSURL(string:urlString){
            URLSession.shared.dataTask(with: url  as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error ?? "error")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                    if cornerRadius != 0 {
                       self.layer.masksToBounds = true;
                       self.layer.cornerRadius = cornerRadius;
                       self.clipsToBounds = true;
                    }
                })
            }).resume()
        }
    }
}
