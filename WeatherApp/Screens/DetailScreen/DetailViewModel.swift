//
//  DetailViewModel.swift
//  WeatherApp
//
//  Created by Alper Gok on 20.03.2025.
//

import UIKit

class DetailViewModel {
    private var weather: WeatherResponse?

    init(weather: WeatherResponse? = nil) {
        self.weather = weather
    }
    
}
