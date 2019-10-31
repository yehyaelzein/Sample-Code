//
//  Date+Extension.swift
//
//  Created by Yehya El Zein on 8/15/18.


import Foundation

extension Date
{
    init(dateString:String, format: String = Constants.SERVER_DATE_FORMAT) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = format;
        dateStringFormatter.locale = Locale(identifier: Constants.DATE_LOCALE)
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: Constants.DATE_LOCALE)
        return dateFormatter.string(from: self).capitalized
    }
}

