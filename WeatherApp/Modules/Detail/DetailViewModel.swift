//
//  DetailViewModel.swift
//  WeatherApp
//
//  Created by Alper Gok on 20.03.2025.
//

import UIKit

class DetailViewModel {
    public var weather: WeatherResponse?
    var weatherProperties: [WeatherProperty] = []
    
    init(weather: WeatherResponse) {
        self.weather = weather
        updateWeatherProperties()
    }
    
    private func updateWeatherProperties() {
        if let weather = weather {
            weatherProperties = [
                WeatherProperty(icon: UIImage(systemName: "humidity.fill"), description: "Humidity\n\(weather.main?.humidity ?? 0)%"),
                WeatherProperty(icon: UIImage(systemName: "thermometer"), description: "Temp\n" + String(format:"%.0f", weather.main?.temp?.rounded() ?? 0) + "°C"),
                WeatherProperty(icon: UIImage(systemName: "wind"), description: "Wind\n\(weather.wind?.speed ?? 0) km/h"),
                WeatherProperty(icon: UIImage(systemName: "gauge"), description: "Pressure\n\(weather.main?.pressure ?? 0) hPa"),
                WeatherProperty(icon: UIImage(systemName: "flag"), description: "Country\n\(weather.sys?.country ?? "n/a")")
            ]
        } else {
            weatherProperties = [
                WeatherProperty(icon: UIImage(systemName: "humidity.fill"), description: "Humidity\n--%"),
                WeatherProperty(icon: UIImage(systemName: "thermometer"), description: "Temp\n--°C"),
                WeatherProperty(icon: UIImage(systemName: "wind"), description: "Wind\n-- km/h"),
                WeatherProperty(icon: UIImage(systemName: "gauge"), description: "Pressure\n-- hPa"),
                WeatherProperty(icon: UIImage(systemName: "flag"), description: "Country\n--")
            ]
        }
    }
    
}
