//
//  NSObject+Extension.swift
//  Created by SaraAwad on 8/10/18.

import Foundation


extension NSObject{
    
    public func localeString(_ key : String, _ comment:String="") -> String {
        let userLang = LocalRepository.GetCulture()
        let bundlePath = Bundle.main.path(forResource: userLang, ofType: ".lproj")
        if bundlePath == nil {
            return NSLocalizedString(key, comment: comment)
        }
        
        let languageBundle = Bundle(path: bundlePath!)
        let translatedString = languageBundle?.localizedString(forKey: key, value: "", table: nil)
        if translatedString == nil {
            return NSLocalizedString(key, comment: comment)
        }
        if translatedString!.isEmpty {
            return NSLocalizedString(key, comment: comment)
        }
        return translatedString!
    }
}
