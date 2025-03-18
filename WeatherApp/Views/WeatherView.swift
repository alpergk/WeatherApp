//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit

class WeatherView: UIViewController {
    
    
    private let viewModel: WeatherViewModel
    private let searchView: WeatherSearchView
    
    
    init(viewModel: WeatherViewModel, searchView: WeatherSearchView) {
        self.viewModel = viewModel
        self.searchView = searchView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
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
    
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
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
        setupBackground()
        setupSearchView()
        setupCollectionView()
    }
    
    private func setupBackground() {
        searchView.backgroundColor = .systemCyan
        view.backgroundColor = .systemCyan
    }
    
    
    private func setupSearchView() {
        view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
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
                self.searchView.loadImage(from: iconURL, placeholder: UIImage(systemName: "exclamationmark.triangle"))
            }
            self.searchView.getCurrentTemp(with: weatherData.main?.temp?.rounded(FloatingPointRoundingRule.toNearestOrAwayFromZero) ?? 0)
        }
    }
    
    func didFailFetchingWeather(with error: any Error) {
        showAlert(title: "Invalid City Name", message: "Please enter a valid city name")
        print(error)
    }
}


extension WeatherView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let city = textField.text?.trimmingCharacters(in: .whitespaces), !city.isEmpty else {
            showAlert(title: "Invalid Input", message: "Please enter a valid city name")
            return false
        }
        
        viewModel.fetchWeather(city: city)
        textField.text = ""
        view.endEditing(true)
        return true
    }
    
    
}

extension WeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weatherProperties.isEmpty ? 0 : viewModel.weatherProperties.count
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
        guard let city = query?.trimmingCharacters(in: .whitespaces) , !city.isEmpty else {
            showAlert(title: "Invalid Input", message: "Please Enter a valid city name")
            return
            
        }
        viewModel.fetchWeather(city: city)
    }
    
    func didTapCurrentLocationButton() {
        LocationManager.shared.getCurrentLocation { latitude, longitude in
            self.viewModel.fetchWeather(latitude: "\(latitude)", longitude: "\(longitude)")
        }
    }
    
    
    
}

