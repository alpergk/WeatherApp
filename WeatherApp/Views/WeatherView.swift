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
    
    
    private var searchButton: UIButton {
        return searchView.searchButton
    }
    
    private var currentLocationButton: UIButton {
        return searchView.currentLocationButton
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .systemBackground
        setupUI()
        setupActions()
        searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        currentLocationButton.addTarget(self, action: #selector(didTapCurrentLocationButton), for: .touchUpInside)
        createDismissKeyboardTapGesture()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupActions() {
        searchView.searchField.delegate = self
    }
    
    
    @objc func didTapSearchButton() {
        guard let city = searchView.searchField.text, !city.isEmpty else {
            return
        }
        
        viewModel.fetchWeather(for: city)
        
        searchView.searchField.text = ""
        
        view.endEditing(true)
        
    }
    
    @objc func didTapCurrentLocationButton() {
        LocationManager.shared.getCurrentLocation { latitude, longitude in
            self.viewModel.fetchWeatherByCurrentLocation(latitude: "\(latitude)", longitude: "\(longitude)")
        }
        searchView.searchField.text = ""
        view.endEditing(true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)  // This will dismiss the keyboard
    }
    
    
    private var weatherProperties: [(UIImage?, String)] {
        return [
            (UIImage(systemName: "humidity.fill"), "Humidity\n\(viewModel.weather?.main?.humidity ?? 0)%"),
            (UIImage(systemName: "thermometer"), "Temp\n\(viewModel.weather?.main?.temp ?? 0)°C"),
            (UIImage(systemName: "wind"), "Wind\n\(viewModel.weather?.wind?.speed ?? 0) km/h"),
            (UIImage(systemName: "gauge"), "Pressure\n\(viewModel.weather?.main?.pressure ?? 0) hPa"),
            (UIImage(systemName: "cloud.rain"), "Rain\n\(viewModel.weather?.cod) mm")
        ]
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 80)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WeatherPropertyCell.self, forCellWithReuseIdentifier: WeatherPropertyCell.reuseID)
        
        return collectionView
    }()
    
    
    func setupUI() {
        view.addSubview(searchView)
        view.addSubview(collectionView)
        searchView.backgroundColor = .systemBlue
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 300),
            
            collectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
            
            
        ])
    }
}

extension WeatherView: WeatherViewModelDelegate {
    func didFetchWeatherSuccessfully() {
        guard let weatherData = viewModel.weather else { return }
        DispatchQueue.main.async {
            self.searchView.locationLabel.text = weatherData.name
        }
    }
    
    func didFailFetchingWeather(with error: any Error) {
        print(error)
    }
    
    
}

extension WeatherView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.fetchWeather(for: textField.text ?? "Konya")
        textField.text = ""
        view.endEditing(true)
        return true
    }
    
    
}

extension WeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherProperties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherPropertyCell.reuseID, for: indexPath) as! WeatherPropertyCell
        let data = weatherProperties[indexPath.row]
        cell.set(image: data.0, text: data.1)
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
        return cell
        
    }
    
    
}

