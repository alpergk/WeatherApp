//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Alper Gok on 12.03.2025.
//

//   let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: jsonData)

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let wind: Wind?
    let dt: Int?
    let sys: Sys?
    let timezone, id: Int?
    let name: String?
    let cod: Int?
}


// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double?
    let feelsLike: Double?
    let pressure, humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Int?
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
}
