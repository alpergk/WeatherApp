//
//  Date+Ext.swift
//  WeatherApp
//
//  Created by Alper Gok on 21.03.2025.
//

import UIKit



extension Date {
    static func formattedDate(
        from unixTimestamp: Int,
        timezoneOffset: Int = 0,
        format: String      = "MMM dd, yyyy HH:mm"
    ) -> String {
        let date          = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        
        
        dateFormatter.timeZone   = TimeZone(secondsFromGMT: timezoneOffset)
        dateFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
