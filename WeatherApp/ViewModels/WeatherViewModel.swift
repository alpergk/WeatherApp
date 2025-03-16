//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit
import NetworkLayer

let appId   = "ef6b401f3a917b4a419a9908342eeff1"
let weatherApiConfig = WeatherAPIConfiguration()


protocol WeatherViewModelDelegate: AnyObject {
    func didFetchWeatherSuccessfully()
    func didFailFetchingWeather(with error: Error)
}
@MainActor
class WeatherViewModel {
    
    weak var delegate: WeatherViewModelDelegate?
    private(set) var weather: WeatherResponse?
    
    var weatherProperties: [WeatherProperty] {
        if let weather = weather {
            return [
                WeatherProperty(icon: UIImage(systemName: "humidity.fill"), description: "Humidity\n\(weather.main?.humidity ?? 0)%"),
                WeatherProperty(icon: UIImage(systemName: "thermometer"), description: String(format:"%.0f",weather.main?.temp?.rounded(FloatingPointRoundingRule.toNearestOrAwayFromZero) ?? 0)+"°C"),
                WeatherProperty(icon: UIImage(systemName: "wind"), description: "Wind\n\(weather.wind?.speed ?? 0) km/h"),
                WeatherProperty(icon: UIImage(systemName: "gauge"), description: "Pressure\n\(weather.main?.pressure ?? 0) hPa"),
                WeatherProperty(icon: UIImage(systemName: "flag"), description: "Country\n\(weather.sys?.country ?? "n/a")"),
            ]
        } else {
            return [
                WeatherProperty(icon: UIImage(systemName: "humidity.fill"), description: "Humidity\n--%"),
                WeatherProperty(icon: UIImage(systemName: "thermometer"), description: "Temp\n--°C"),
                WeatherProperty(icon: UIImage(systemName: "wind"), description: "Wind\n-- km/h"),
                WeatherProperty(icon: UIImage(systemName: "gauge"), description: "Pressure\n-- hPa"),
                WeatherProperty(icon: UIImage(systemName: "flag"), description: "Country\n--"),
            ]
        }
    }
    
    
    func fetchWeather(city: String? = nil, latitude: String? = nil, longitude: String? = nil) {
        Task {
            do {
                let weatherData: WeatherResponse
                
                if let city = city {
                    weatherData = try await NetworkManager.shared.request(endpoint: createWeatherEndpoint(for: city))
                } else if let lat = latitude, let lon = longitude {
                    weatherData = try await NetworkManager.shared.request(endpoint: createWeatherCurrentLocationEndpoint(for: lat, lon: lon))
                } else {
                    print("Error: Provide either a city or latitude & longitude")
                    return
                }
                
                self.weather = weatherData
                delegate?.didFetchWeatherSuccessfully()
                
            } catch {
                delegate?.didFailFetchingWeather(with: error)
            }
        }
    }
    
    
    
    
}



private func createWeatherEndpoint(for city : String) -> Endpoint {
    return Endpoint.customRequest(
        config: weatherApiConfig,
        path: "/weather",
        method: .get,
        parameters: ["q": city, "appid": appId, "units": "metric"],
        headers: [:]
    )
}

private func createWeatherCurrentLocationEndpoint(for lat: String, lon: String) -> Endpoint {
    return Endpoint.customRequest(
        config: weatherApiConfig,
        path: "/weather",
        method: .get,
        parameters: ["lat": lat, "lon": lon, "appid": appId, "units": "metric"],
        headers: [:]
    )
}


struct WeatherProperty {
    let icon: UIImage?
    let description: String
}


