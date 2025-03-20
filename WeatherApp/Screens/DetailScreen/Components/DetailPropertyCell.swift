//
//  DetailCollectionViewCell.swift
//  WeatherApp
//
//  Created by Alper Gok on 20.03.2025.
//

import UIKit

class DetailPropertyCell: UICollectionViewCell {
    static let reuseID = "detailPropertyCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let propertyDetailsLabel = DetailLabel(textAlignment: .center, textColor: .secondaryLabel, customSize: 14)
    
    let propertyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func set(image: UIImage, description: String) {
        self.propertyImageView.image = image
        self.propertyDetailsLabel.text = description
    }
    
    private func configure() {
        
        contentView.addSubview(propertyImageView)
        contentView.addSubview(propertyDetailsLabel)
        
        
        
        NSLayoutConstraint.activate([
            propertyImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            propertyImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            propertyImageView.widthAnchor.constraint(equalToConstant: 40),
            propertyImageView.heightAnchor.constraint(equalToConstant: 40),
            
            propertyDetailsLabel.topAnchor.constraint(equalTo: propertyImageView.bottomAnchor, constant: 5),
            propertyDetailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            propertyDetailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            propertyDetailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    
    
    
}
