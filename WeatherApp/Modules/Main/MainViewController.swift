//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Alper Gok on 19.03.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private let mainView: MainView
    private let weatherViewModel: WeatherViewModel
    private let loadingView =  LoadingView()
    
    init(mainView: MainView, mainViewModel: WeatherViewModel) {
        self.mainView = mainView
        self.weatherViewModel = mainViewModel
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
        weatherViewModel.delegate = self
        dismissKeyboardTapGesture()
        
    }
    
    private func dismissKeyboardTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    private func setupView() {
        view.addSubview(mainView)
        view.backgroundColor = .systemBackground
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
        weatherViewModel.fetchWeather(city: text)
        mainView.searchTextField.text = ""
        dismissKeyboard()
    }
    
    func didTapCurrentLocationButton() {
        LocationManager.shared.getCurrentLocation { [weak self] latitude, longitude in
            guard let self else { return }
            self.weatherViewModel.fetchWeather(latitude: "\(latitude)", longitude: "\(longitude)")
            mainView.searchTextField.text = ""
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherViewModel.fetchWeather(city: textField.text)
        textField.text = ""
        dismissKeyboard()
        return true
    }
    
    
}

extension MainViewController: WeatherViewModelDelegate {
    
    // FIXME: -  Check this out later, there might be an issue about the design of viewmodels ??
    func didFetchWeatherSuccessfully(with properties: [WeatherProperty]) {
        //Main view controller can update its own UI. Currently this is not needed here it seems.
    }
    
    func didFailFetchingWeather(with error: any Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
    func didStartLoading() {
        loadingView.show(in: view)
    }
    
    func didStopLoading() {
        loadingView.hide()
    }
    
    
}


