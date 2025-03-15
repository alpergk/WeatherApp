//
//  WeatherSearchView.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit

class WeatherSearchView: UIView {
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        //label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    
    
    let searchField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth  = 2
        textField.layer.borderColor  = UIColor.systemGray4.cgColor
        
        textField.textColor          = .label
        textField.tintColor          = .label
        textField.font               = UIFont.preferredFont(forTextStyle: .title2)
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize    = 12
        
        textField.backgroundColor    = .tertiarySystemBackground
        textField.autocorrectionType = .no
        textField.returnKeyType      = .search
        textField.clearButtonMode    = .whileEditing
        textField.placeholder        = "Search for a city"
        textField.textAlignment      = .center
        
        return textField
    }()
    
    
    let searchButton: UIButton = {
        var config = UIButton.Configuration.filled()  // Use a filled button style
        config.baseBackgroundColor = .systemPurple    // Button background color
        config.baseForegroundColor = .white           // Icon color
        config.cornerStyle = .capsule                 // Ensures it remains circular
        config.image = UIImage(systemName: "magnifyingglass")  // Add search icon
        config.imagePlacement = .all                  // Center the icon
        config.buttonSize = .medium                   // Adjust button size
        
        let button = UIButton(configuration: config)  // Apply the configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white  // Ensure the icon is visible
        
        
        return button
    }()
    
    let currentLocationButton: UIButton = {
        var config = UIButton.Configuration.filled()  // Use a filled button style
        config.baseBackgroundColor = .systemOrange    // Button background color
        config.baseForegroundColor = .white           // Icon color
        config.cornerStyle = .capsule                 // Ensures it remains circular
        config.image = UIImage(systemName: "location")  // Add search icon
        config.imagePlacement = .all                  // Center the icon
        config.buttonSize = .medium                   // Adjust button size
        
        let button = UIButton(configuration: config)  // Apply the configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white  // Ensure the icon is visible
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSearchFieldUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSearchFieldUI() {
        addSubview(searchField)
        addSubview(searchButton)
        addSubview(currentLocationButton)
        addSubview(locationLabel)
        
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchField.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchField.widthAnchor.constraint(equalToConstant: 250), // Adjust width as needed
            searchField.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor), // Align vertically
            searchButton.leadingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: 10), // Space between field and button
            searchButton.widthAnchor.constraint(equalToConstant: 36), // Make it a square
            searchButton.heightAnchor.constraint(equalToConstant: 36),
            
            // Ensure it doesn't exceed the screen width
            searchButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            
            currentLocationButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            currentLocationButton.trailingAnchor.constraint(equalTo: searchField.leadingAnchor, constant: -10),
            currentLocationButton.widthAnchor.constraint(equalToConstant: 36),
            currentLocationButton.heightAnchor.constraint(equalToConstant: 36),
            
            currentLocationButton.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 20),
            
            locationLabel.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20),
            locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            locationLabel.widthAnchor.constraint(equalToConstant: 250),
            locationLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
