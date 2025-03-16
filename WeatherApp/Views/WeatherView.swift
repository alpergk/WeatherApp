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
        searchView.delegate = self
        setupUI()
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
    
    
    
    
    @objc func didTapSearchButton() {
        guard let city = searchView.searchField.text?.trimmingCharacters(in: .whitespaces), !city.isEmpty else {
            print("Invalid Value Entered")
            return
        }
        
        viewModel.fetchWeather(city: city)
        
        searchView.searchField.text = ""
        
        view.endEditing(true)
        
    }
    
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        searchView.backgroundColor = .systemCyan
        view.backgroundColor = .systemCyan
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 200),
            
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
            self.collectionView.reloadData()
            
            if let iconName = weatherData.weather?.first?.icon {
                let iconURL = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
                self.searchView.loadImage(from: iconURL, placeholder: UIImage(systemName: ""))
            }
            
            self.searchView.getCurrentTemp(with: weatherData.main?.temp?.rounded(FloatingPointRoundingRule.toNearestOrAwayFromZero) ?? 0)
        }
        
        
    }
    
    func didFailFetchingWeather(with error: any Error) {
        print(error)
    }
    
    
}

extension WeatherView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.fetchWeather(city: textField.text)
        textField.text = ""
        view.endEditing(true)
        return true
    }
    
    
}

extension WeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weatherProperties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherPropertyCell.reuseID, for: indexPath) as? WeatherPropertyCell else {
            return UICollectionViewCell()
        }
        let data = viewModel.weatherProperties[indexPath.row]
        cell.set(image: data.icon, text: data.description)
        return cell
        
    }
    
    
}

extension WeatherView: WeatherSearchViewDelegate {
    
    func didTapSearchButton(with query: String?) {
        guard let city = query, !city.isEmpty else { return }
        viewModel.fetchWeather(city: city)
    }
    
    func didTapCurrentLocationButton() {
        LocationManager.shared.getCurrentLocation { latitude, longitude in
            self.viewModel.fetchWeather(latitude: "\(latitude)", longitude: "\(longitude)")
        }
    }
    
    
    
}

