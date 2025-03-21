//
//  MainView.swift
//  WeatherApp
//
//  Created by Alper Gok on 19.03.2025.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func didTapSearchButton(with text: String)
    func didTapCurrentLocationButton()
}

class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButtonActions()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let searchTextField: UITextField = {
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
    
    private let searchButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.baseBackgroundColor = .systemPurple
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "magnifyingglass")
        config.imagePlacement = .all
        config.buttonSize = .medium
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let currentLocationButton: UIButton = {
        var config = UIButton.Configuration.bordered()
        config.baseBackgroundColor = .systemPurple
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "location")
        config.imagePlacement = .all
        config.buttonSize = .medium
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private func setupUI() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(currentLocationButton)
        mainStackView.addArrangedSubview(searchTextField)
        mainStackView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            searchButton.heightAnchor.constraint(equalToConstant: 44),
            searchButton.widthAnchor.constraint(equalToConstant: 44),
            
            currentLocationButton.heightAnchor.constraint(equalToConstant: 44),
            currentLocationButton.widthAnchor.constraint(equalToConstant: 44),
    
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    private func configureButtonActions() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
        let text = searchTextField.text ?? ""
        delegate?.didTapSearchButton(with: text)
    }
    
    @objc func currentLocationButtonTapped() {
        delegate?.didTapCurrentLocationButton()
    }
  
    
    
}

