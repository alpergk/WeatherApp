//
//  MainCoordinatorDelegate.swift
//  WeatherApp
//
//  Created by Alper Gok on 21.03.2025.
//


import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    @MainActor func didSelectWeatherData(_ weather: WeatherResponse)
}
