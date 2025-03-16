//
//  WeatherAPIConfiguration.swift
//  WeatherApp
//
//  Created by Alper Gok on 12.03.2025.
//

import Foundation
import NetworkLayer




//https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=ef6b401f3a917b4a419a9908342eeff1
//https://api.openweathermap.org/data/2.5/weather?q=Yalova&appid=ef6b401f3a917b4a419a9908342eeff1
//https://openweathermap.org/img/wn/10d@2x.png


struct WeatherAPIConfiguration: APIConfiguration {
    var baseURL = "https://api.openweathermap.org/data/2.5"
    
    var defaultHeaders:[String: String]? = ["Content-Type": "application/json"]
}


