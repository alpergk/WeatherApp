//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit
import NetworkLayer


protocol WeatherViewModelDelegate: AnyObject {
    func didFetchWeatherSuccessfully(with properties: [WeatherProperty])
    func didFailFetchingWeather(with error: Error)
    func didStartLoading()
    func didStopLoading()
}


@MainActor
final class WeatherViewModel {
    
    
    
    weak var delegate: WeatherViewModelDelegate?
    weak var coordinatorDelegate: MainCoordinatorDelegate?
    private(set) var weather: WeatherResponse?
    var weatherProperties: [WeatherProperty] = []
    
    
    
    
    
    func fetchWeather(city: String? = nil, latitude: String? = nil, longitude: String? = nil) {
        if let city = city?.trimmingCharacters(in: .whitespaces), city.isEmpty {
            delegate?.didFailFetchingWeather(with: NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Please enter a valid city name."]))
            return
        }
        
        if city == nil, (latitude == nil || longitude == nil) {
            delegate?.didFailFetchingWeather(with: NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid location. Provide either a city name or latitude & longitude."]))
            return
        }
        
        Task {
            delegate?.didStartLoading()
            defer { delegate?.didStopLoading() }
            do {
                let weatherData: WeatherResponse
                if let city = city {
                    weatherData = try await NetworkManager.shared.request(endpoint: createWeatherEndpoint(for: city))
                } else if let lat = latitude, let lon = longitude {
                    weatherData = try await NetworkManager.shared.request(endpoint: createWeatherCurrentLocationEndpoint(for: lat, lon: lon))
                } else {
                    return 
                }
                
                self.weather = weatherData
                
                updateWeatherProperties()
                delegate?.didFetchWeatherSuccessfully(with: weatherProperties)
                coordinatorDelegate?.didSelectWeatherData(weatherData)
                
            } catch {
                let errorMessage: String
                if error.localizedDescription.lowercased().contains("the operation") {
                    errorMessage = "City not found. Please enter a valid city name."
                } else {
                    errorMessage = error.localizedDescription
                }
                
                let userFriendlyError = NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                
                
                delegate?.didFailFetchingWeather(with: userFriendlyError)
            }
        }
    }

    
    
    
    private func updateWeatherProperties() {
        if let weather = weather {
            weatherProperties = [
                WeatherProperty(icon: UIImage(systemName: "humidity.fill"), description: "Humidity\n\(weather.main?.humidity ?? 0)%"),
                WeatherProperty(icon: UIImage(systemName: "thermometer"), description: String(format:"%.0f",weather.main?.temp?.rounded(FloatingPointRoundingRule.toNearestOrAwayFromZero) ?? 0)+"°C"),
                WeatherProperty(icon: UIImage(systemName: "wind"), description: "Wind\n\(weather.wind?.speed ?? 0) km/h"),
                WeatherProperty(icon: UIImage(systemName: "gauge"), description: "Pressure\n\(weather.main?.pressure ?? 0) hPa"),
                WeatherProperty(icon: UIImage(systemName: "flag"), description: "Country\n\(weather.sys?.country ?? "n/a")"),
            ]
        } else {
            weatherProperties = [
                WeatherProperty(icon: UIImage(systemName: "humidity.fill"), description: "Humidity\n--%"),
                WeatherProperty(icon: UIImage(systemName: "thermometer"), description: "Temp\n--°C"),
                WeatherProperty(icon: UIImage(systemName: "wind"), description: "Wind\n-- km/h"),
                WeatherProperty(icon: UIImage(systemName: "gauge"), description: "Pressure\n-- hPa"),
                WeatherProperty(icon: UIImage(systemName: "flag"), description: "Country\n--"),
            ]
        }
    }
}



private func createWeatherEndpoint(for city : String) -> Endpoint {
    return Endpoint.customRequest(
        config: Constants.weatherApiConfig,
        path: "/weather",
        method: .get,
        parameters: ["q": city, "appid": Constants.appId, "units": "metric"],
        headers: [:]
    )
}

private func createWeatherCurrentLocationEndpoint(for lat: String, lon: String) -> Endpoint {
    return Endpoint.customRequest(
        config: Constants.weatherApiConfig,
        path: "/weather",
        method: .get,
        parameters: ["lat": lat, "lon": lon, "appid": Constants.appId, "units": "metric"],
        headers: [:]
    )
}





