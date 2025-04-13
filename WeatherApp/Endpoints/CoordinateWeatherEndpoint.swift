//
//  CoordinateWeatherEndpoint.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.04.2025.
//

import NetworkLayer


struct CoordinateWeatherEndpoint: Endpoint {
    let path: String
    let method: HTTPMethod
    let parameters: [String: Any]?
    let headers: [String: String]?
    
    init(lat: String, lon: String) {
        path = "/weather"
        method = .get
        parameters = [
            "lat": lat,
            "lon": lon,
            "appid": Constants.appId,
            "units": "metric"
        ]
        headers = nil
    }
}
