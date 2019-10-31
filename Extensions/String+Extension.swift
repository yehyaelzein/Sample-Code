//
//  String+Extension.swift
//
//  Created by Yehya El Zein on 8/16/18.

import Foundation
import UIKit

extension String{
    func RemovingCharacters(inCharacterSet forbiddenCharacters:CharacterSet) -> String
    {
        var filteredString = self
        while true {
            if let forbiddenCharRange = filteredString.rangeOfCharacter(from: forbiddenCharacters)  {
                filteredString.removeSubrange(forbiddenCharRange)
            }
            else {
                break
            }
        }
        return filteredString
    }
    func toEnglishNumber()-> NSNumber{
        let numberFormatter = NumberFormatter();
        numberFormatter.locale = Locale(identifier: CULTURE.ENGLISH.rawValue);
        numberFormatter.numberStyle = .decimal;
        numberFormatter.groupingSeparator = ","
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        if let number = numberFormatter.number(from: self){
            return number;
        }
        return NSNumber();
    }
    func GetDateTime(_ format:String)-> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format;
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        guard let timeDate = dateFormatter.date(from: self) else {return Date()}
        return timeDate;
    }
    func IsValidEmail()->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx);
        return emailPredicate.evaluate(with:self);
    }
    func IsNumber()->Bool{
        let numberRegEx = "[0-9]+";
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegEx);
        return numberPredicate.evaluate(with:self);
    }
    //MARK: Checks if the text field is empty or not
    public func IsEmpty() -> Bool{
        return TrimText().isEmpty
    }
    //MARK: Removes whitespaces and new lines from a string
    public func TrimText() -> String{
        return (self.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
//    subscript (r: Range<Int>) -> String {
//        get {
//            let start = index(startIndex, offsetBy: r.lowerBound)
//            let end = index(startIndex, offsetBy: r.upperBound)
//            return String(self[Range(start ..< end)])
//        }
//    }
    
    subscript(value: PartialRangeUpTo<Int>) -> String {
        get {
            return String(self[..<index(startIndex, offsetBy: value.upperBound)])
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> String {
        get {
            return String(self[...index(startIndex, offsetBy: value.upperBound)])
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> String {
        get {
            return String(self[index(startIndex, offsetBy: value.lowerBound)...])
        }
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlParagraphString:NSMutableAttributedString?{
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified;
            let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.baselineOffset: NSNumber(value: 0)
            ]
            let result = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            result.addAttributes(attributes, range: NSRange(location: 0, length:result.length));
            return result;
        } catch {
            return NSMutableAttributedString()
        }
    }
    var htmlParToAttributedString:NSMutableAttributedString?{
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        var paragraphStyle = NSMutableParagraphStyle();
        paragraphStyle.alignment = .right;
        paragraphStyle.lineSpacing = 14 //Change spacing between lines
        paragraphStyle.paragraphSpacing = 20
        do {
            let result =  try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil);
            result.addAttributes([
                NSAttributedString.Key.font:UIFont(name:Constants.DEFAULT_FONT,size:20)!,
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.backgroundColor: UIColor.clear,
                NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length:result.length))
            return result;
        } catch {
            return NSMutableAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? "";
    }
    var htmlParToString:String{
        return htmlParToAttributedString?.string ?? "";
    }
}
