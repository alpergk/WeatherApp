////
////  WeatherSearchView.swift
////  WeatherApp
////
////  Created by Alper Gok on 13.03.2025.
////
//
//import UIKit
//
//protocol WeatherSearchViewDelegate: AnyObject {
//    func didTapSearchButton(with query: String?)
//    func didTapCurrentLocationButton()
//}
//
//class WeatherSearchView: UIView {
//    
//    weak var delegate: WeatherSearchViewDelegate?
//    static let imageCache = NSCache<NSString, UIImage>()
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        setupActions()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    var locationLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 24, weight: .bold)
//        label.textAlignment = .center
//        label.text = ""
//        return label
//    }()
//    
//    
//    
//    let searchField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        textField.layer.cornerRadius = 12
//        textField.layer.borderWidth  = 2
//        textField.layer.borderColor  = UIColor.systemGray4.cgColor
//        
//        textField.textColor          = .label
//        textField.tintColor          = .label
//        textField.font               = UIFont.preferredFont(forTextStyle: .title2)
//        textField.adjustsFontSizeToFitWidth = true
//        textField.minimumFontSize    = 12
//        
//        textField.backgroundColor    = .tertiarySystemBackground
//        textField.autocorrectionType = .no
//        textField.returnKeyType      = .search
//        textField.clearButtonMode    = .whileEditing
//        textField.placeholder        = "Search for a city"
//        textField.textAlignment      = .center
//        
//        return textField
//    }()
//    
//    
//    let searchButton: UIButton = {
//        var config = UIButton.Configuration.borderless()
//        config.baseBackgroundColor = .systemPurple
//        config.baseForegroundColor = .white
//        config.cornerStyle = .capsule
//        config.image = UIImage(systemName: "magnifyingglass")
//        config.imagePlacement = .all
//        config.buttonSize = .medium
//        
//        let button = UIButton(configuration: config)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .white
//        
//        
//        return button
//    }()
//    
//    let currentLocationButton: UIButton = {
//        var config = UIButton.Configuration.filled()
//        config.baseBackgroundColor = .systemOrange
//        config.baseForegroundColor = .white
//        config.cornerStyle = .capsule
//        config.image = UIImage(systemName: "location")
//        config.imagePlacement = .all
//        config.buttonSize = .large
//        
//        let button = UIButton(configuration: config)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .white
//        return button
//    }()
//    
//    private var temperatureLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .label
//        label.font = .systemFont(ofSize: 22, weight: .bold)
//        label.textAlignment = .center
//        label.text = "-°C"
//        return label
//    }()
//    
//    private var weatherImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.tintColor = .label
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(systemName: "")
//        return imageView
//    }()
//    
//    private let weatherStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.spacing = 8
//        stackView.alignment = .center
//        stackView.distribution = .fill
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//    
//  
//    
//    func setupUI() {
//        
//        let searchStackView = UIStackView(arrangedSubviews: [currentLocationButton,searchField, searchButton])
//        searchStackView.axis = .horizontal
//        searchStackView.spacing = 10
//        searchStackView.alignment = .center
//        searchStackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        weatherStackView.addArrangedSubview(weatherImageView)
//        weatherStackView.addArrangedSubview(temperatureLabel)
//        
//        addSubview(searchStackView)
//        addSubview(locationLabel)
//        addSubview(weatherStackView)
//        
//        NSLayoutConstraint.activate([
//            searchStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
//            searchStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            searchStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            searchStackView.heightAnchor.constraint(equalToConstant: 40),
//            
//            
//            
//            currentLocationButton.widthAnchor.constraint(equalToConstant: 30),
//            currentLocationButton.heightAnchor.constraint(equalToConstant: 30),
//            
//            searchButton.widthAnchor.constraint(equalToConstant: 30),
//            searchButton.heightAnchor.constraint(equalToConstant: 30),
//            
//            
//            locationLabel.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: 20),
//            locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            
//            weatherStackView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
//            weatherStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
//        ])
//    }
//    
//    private func setupActions() {
//        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
//        currentLocationButton.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
//        searchField.delegate = self
//    }
//    
//    func getCurrentTemp(with tempLabel: Double) {
//        self.temperatureLabel.text = String(format: "%.0f",  tempLabel) + "°C"
//    }
//    
//    @objc private func searchTapped() {
//        delegate?.didTapSearchButton(with: searchField.text ?? "")
//        searchField.text = ""
//    }
//    
//    
//    @objc private func locationTapped() {
//        delegate?.didTapCurrentLocationButton()
//        searchField.text = ""
//    }
//    
//    
//}
//
//extension WeatherSearchView: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        delegate?.didTapSearchButton(with: textField.text ?? "")
//        textField.text = ""
//        endEditing(true)
//        return true
//    }
//}
//
//
//// MARK: -  Image Load / Caching
//extension WeatherSearchView {
//    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
//        self.weatherImageView.image = placeholder
//        let cacheKey = NSString(string: urlString)
//        
//        if let cachedImage = WeatherSearchView.imageCache.object(forKey: cacheKey) {
//            weatherImageView.image = cachedImage
//            return
//        }
//        
//        guard let url = URL(string: urlString) else { return }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response , error in
//            guard let data = data, let downloadedImage = UIImage(data: data), error == nil else {
//                DispatchQueue.main.async {
//                    self.weatherImageView.image = UIImage(systemName: "exclamationmark.triangle")
//                }
//                return
//            }
//            
//            WeatherSearchView.imageCache.setObject(downloadedImage, forKey: urlString as NSString)
//            
//            DispatchQueue.main.async {
//                self.weatherImageView.image = downloadedImage
//            }
//        }
//        
//        task.resume()
//        
//        
//        
//    }
//}
