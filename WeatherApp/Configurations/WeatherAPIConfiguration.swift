//
//  WeatherAPIConfiguration.swift
//  WeatherApp
//
//  Created by Alper Gok on 12.03.2025.
//

import Foundation
import NetworkLayer

struct WeatherAPIConfiguration: APIConfiguration {
    var baseURL = "https://api.openweathermap.org/data/2.5"
    
    var defaultHeaders:[String: String]? = ["Content-Type": "application/json"]
}


