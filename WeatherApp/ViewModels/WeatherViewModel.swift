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

class WeatherViewModel {
    
    weak var delegate: WeatherViewModelDelegate?
    private(set) var weather: WeatherResponse?
    
    func fetchWeather(for city: String) {
        Task {
            do {
                let weatherData: WeatherResponse = try await NetworkManager.shared.request(endpoint: createWeatherEndpoint(for: city))
                self.weather = weatherData //Store Data
                delegate?.didFetchWeatherSuccessfully() //Notify UI
                
            } catch {
                delegate?.didFailFetchingWeather(with: error)
            }
        }
    }
    
    func fetchWeatherByCurrentLocation(latitude: String, longitude: String) {
        Task {
            do {
                let weatherData: WeatherResponse = try await NetworkManager.shared.request(endpoint: createWeatherCurrentLocationEndpoint(for: latitude, lon: longitude))
                self.weather = weatherData
                delegate?.didFetchWeatherSuccessfully()
            } catch {
                delegate?.didFailFetchingWeather(with: error)
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
}
