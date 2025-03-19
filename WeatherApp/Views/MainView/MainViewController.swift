//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Alper Gok on 19.03.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainView: MainView
    private let mainViewModel: WeatherViewModel
    
    init(mainView: MainView, mainViewModel: WeatherViewModel) {
        self.mainView = mainView
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mainView.delegate = self
        mainView.searchTextField.delegate = self
        mainViewModel.delegate = self
        
    }
    
    func setupView() {
        view.addSubview(mainView)
        view.backgroundColor = .systemYellow
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.pinToEdges(of: view)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    
}

extension MainViewController: MainViewDelegate {
    func didTapSearchButton(with text: String) {
        mainViewModel.fetchWeather(city: text)
    }
    
    func didTapCurrentLocationButton() {
        LocationManager.shared.getCurrentLocation { [weak self] latitude, longitude in
            guard let self else { return }
            self.mainViewModel.fetchWeather(latitude: "\(latitude)", longitude: "\(longitude)")
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainViewModel.fetchWeather(city: textField.text)
        return true
    }
    
    
}

extension MainViewController: WeatherViewModelDelegate {
    func didFetchWeatherSuccessfully(with properties: [WeatherProperty]) {
        //update UI with properties
        //print(properties)
    }
    
    func didFailFetchingWeather(with error: any Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    func didStartLoading() {
        //show loading indicator
    }
    
    func didStopLoading() {
        //hide loading indicator
    }
    
    
}


