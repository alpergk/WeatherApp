//
//  DateFormatStyle.swift
//  WeatherApp
//
//  Created by Alper Gok on 21.03.2025.
//

import Foundation

enum DateFormatStyle {
    case shortTime
    case dayDateTime
    case fullDate
    
    var formatString: String {
        switch self {
        case .shortTime: return "HH:mm"
        case .dayDateTime: return "EE, MMM d, h:mm a"
        case .fullDate: return "MMM dd, yyyy HH:mm"
        }
    }
}
