//
//  CityWeatherEndpoint.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.04.2025.
//
import Foundation
import NetworkLayer

struct CityWeatherEndpoint: Endpoint {
    let path: String
    let method: HTTPMethod
    let parameters: [String: Any]?
    let headers: [String: String]?
    
    init(city: String) {
        path = "/weather"
        method = .get
        parameters = [
            "q": city,
            "appid": Constants.appId,
            "units": "metric"
        ]
        headers = nil
    }
}
