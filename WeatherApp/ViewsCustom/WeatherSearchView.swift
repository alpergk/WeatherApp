//
//  WeatherSearchView.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit

class WeatherSearchView: UIView {
    
    
    
    let searchField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth  = 1
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
        
        
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        icon.tintColor = .gray
        icon.contentMode = .scaleAspectFit
        icon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        textField.rightView = icon
        textField.rightViewMode = .always
        return textField
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
        
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            searchField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
