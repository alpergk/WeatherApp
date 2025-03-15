//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit

class WeatherView: UIViewController {
    
    
    private let viewModel = WeatherViewModel()
    private let searchView = WeatherSearchView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .systemBackground
        setupUI()
        setupActions()
        
        
    }
    
    func getCurrentLocation() {
        LocationManager.shared.getCurrentLocation { latitude, longitude in
            self.viewModel.fetchWeatherByCurrentLocation(latitude: "\(latitude)", longitude: "\(longitude)")
        }
    }
    
    
    func setupUI() {
        view.addSubview(searchView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupActions() {
        searchView.searchField.delegate = self
    }
    
    func whenButtonPressed() {
        print("Button pressed")
    }
    
}

extension WeatherView: WeatherViewModelDelegate {
    func didFetchWeatherSuccessfully() {
        guard let weatherData = viewModel.weather else { return }
        print("City: \(String(describing: weatherData.name)) is \(String(describing: weatherData.main?.temp)) Degree and seems \(String(describing: weatherData.weather![0].icon))")
    }
    
    func didFailFetchingWeather(with error: any Error) {
        print(error)
    }
    
    
}

extension WeatherView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getCurrentLocation()
        return true
    }
    
    
}

