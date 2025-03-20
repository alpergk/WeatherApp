////
////  WeatherView.swift
////  WeatherApp
////
////  Created by Alper Gok on 13.03.2025.
////
//
//import UIKit
//import CoreLocation
//
//class WeatherSearchViewController: UIViewController {
//    
//    enum Section { case main }
//    
//    private let viewModel: WeatherViewModel
//    private let searchView: WeatherSearchView
//    private let loadingView =  LoadingView()
//    private var dataSource: UICollectionViewDiffableDataSource<Section, WeatherProperty>!
//    private let scrollView = UIScrollView()
//    private let contentView = UIView()
//  
//    
//    
//    init(viewModel: WeatherViewModel, searchView: WeatherSearchView) {
//        self.viewModel = viewModel
//        self.searchView = searchView
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//  
//    
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel.delegate = self
//        searchView.delegate = self
//        setupUI()
//        createDismissKeyboardTapGesture()
//        setupDataSource()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
//    
//    private func setupScrollView() {
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        
//        contentView.backgroundColor = .systemCyan
//        scrollView.backgroundColor  = .systemBackground
//        
//        view.addSubview(scrollView)
//        
//        scrollView.pinToEdges(of: view)
//        
//        scrollView.addSubview(contentView)
//        
//        contentView.pinToEdges(of: scrollView)
//        
//        NSLayoutConstraint.activate([
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            contentView.heightAnchor.constraint(equalToConstant: 1200)
//        ])
//        
//        
//    }
//    
//    
//    
//    private func showAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default))
//        self.present(alert, animated: true)
//    }
//    
//    
//    
//    func createDismissKeyboardTapGesture() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//    
//    
//    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        layout.itemSize = CGSize(width: 80, height: 80)
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .clear
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.register(WeatherViewPropertyCell.self, forCellWithReuseIdentifier: WeatherViewPropertyCell.reuseID)
//        
//        return collectionView
//    }()
//    
//    func setupUI() {
//        setupScrollView()
//        setupBackground()
//        setupSearchView()
//        setupCollectionView()
//    }
//    
//    private func setupBackground() {
//        searchView.backgroundColor = .systemYellow
//    }
//    
//    
//    private func setupSearchView() {
//        contentView.addSubview(searchView)
//        searchView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            searchView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
//            searchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            searchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            searchView.heightAnchor.constraint(equalToConstant: 200)
//        ])
//    }
//    
//    private func setupCollectionView() {
//        contentView.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 20),
//            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            collectionView.heightAnchor.constraint(equalToConstant: 100)
//        ])
//    }
//    
//    
//}
//
//extension WeatherSearchViewController: WeatherViewModelDelegate {
//    func didStartLoading() {
//        loadingView.show(in: self.view)
//    }
//    
//    
//    func didStopLoading() {
//        loadingView.hide()
//    }
//    
//    func didFetchWeatherSuccessfully(with properties: [WeatherProperty]) {
//        guard let weatherData = viewModel.weather else { return }
//        
//        DispatchQueue.main.async {
//            self.updateData(with: properties)
//            self.searchView.locationLabel.text = weatherData.name
//            if let iconName = weatherData.weather?.first?.icon {
//                let iconURL = "https://openweathermap.org/img/wn/\(iconName)@2x.png"
//                self.searchView.loadImage(from: iconURL, placeholder: UIImage(systemName: "exclamationmark.triangle"))
//            }
//            self.searchView.getCurrentTemp(with: weatherData.main?.temp?.rounded(FloatingPointRoundingRule.toNearestOrAwayFromZero) ?? 0)
//        }
//    }
//    
//    
//    func didFailFetchingWeather(with error: any Error) {
//        showAlert(title: "Invalid City Name", message: "Please enter a valid city name")
//        print(error)
//    }
//}
//
//
//extension WeatherSearchViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        guard let city = textField.text?.trimmingCharacters(in: .whitespaces), !city.isEmpty else {
//            showAlert(title: "Invalid Input", message: "Please enter a valid city name")
//            return false
//        }
//        
//        viewModel.fetchWeather(city: city)
//        textField.text = ""
//        view.endEditing(true)
//        return true
//    }
//    
//    private func setupDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section, WeatherProperty>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherViewPropertyCell.reuseID, for: indexPath) as? WeatherViewPropertyCell else {
//                return UICollectionViewCell()
//            }
//            cell.set(image: item.icon, text: item.description)
//            return cell
//        })
//    }
//    
//    private func updateData(with properties: [WeatherProperty]) {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherProperty>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(properties)
//        DispatchQueue.main.async {
//            self.dataSource.apply(snapshot, animatingDifferences: true)
//        }
//    }
//    
//}
//
//
//extension WeatherSearchViewController: WeatherSearchViewDelegate {
//    
//    func didTapSearchButton(with query: String?) {
//        guard let city = query?.trimmingCharacters(in: .whitespaces) , !city.isEmpty else {
//            showAlert(title: "Invalid Input", message: "Please Enter a valid city name")
//            return
//            
//        }
//        viewModel.fetchWeather(city: city)
//    }
//    
//    func didTapCurrentLocationButton() {
//        LocationManager.shared.getCurrentLocation { latitude, longitude in
//            self.viewModel.fetchWeather(latitude: "\(latitude)", longitude: "\(longitude)")
//        }
//    }
//    
//    
//    
//}
//
