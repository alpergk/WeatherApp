//
//  WeatherPropertyCell.swift
//  WeatherApp
//
//  Created by Alper Gok on 15.03.2025.
//

import UIKit

class WeatherPropertyCell: UICollectionViewCell {
    static let reuseID = "WeatherPropertyCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.font = UIFont.preferredFont(forTextStyle: .title2)
//        label.numberOfLines = 2
//        label.textColor = .label
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.9
//        label.lineBreakMode = .byTruncatingTaillet label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
       
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func set(image: UIImage?, text: String){
        self.imageView.image = image
        self.label.text = text
    }
    
    
    private func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        

        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
