//
//  DetailView.swift
//  WeatherApp
//
//  Created by Alper Gok on 20.03.2025.
//

import UIKit

class DetailView: UIView {
    
    var temperatureLabel = DetailLabel(textAlignment: .center, textColor: .label, customSize: 44)
    var cityNameLabel    = DetailLabel(textAlignment: .center, textColor: .secondaryLabel, textStyle: .extraLargeTitle2)
    var dateLabel        = DetailLabel(textAlignment: .center, textColor: .secondaryLabel, textStyle: .footnote)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let topWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "sun.min.fill")
        return imageView
    }()
    
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    let bottomCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(DetailPropertyCell.self, forCellWithReuseIdentifier: DetailPropertyCell.reuseID)
        return collectionView
    }()
    
    func setupUI() {
        temperatureLabel.text = "18 oC"
        cityNameLabel.text = "Ankara"
        dateLabel.text = "Today 19:07"
        topStackView.addArrangedSubview(temperatureLabel)
        topStackView.addArrangedSubview(topWeatherImageView)
        topStackView.addArrangedSubview(cityNameLabel)
        topStackView.addArrangedSubview(dateLabel)
        topStackView.setCustomSpacing(50, after: temperatureLabel)
        
        addSubviews(topStackView, bottomCollectionView)
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            topStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            topWeatherImageView.heightAnchor.constraint(equalToConstant: 44),
            topWeatherImageView.widthAnchor.constraint(equalToConstant: 44),
            
            bottomCollectionView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            bottomCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            bottomCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            bottomCollectionView.heightAnchor.constraint(equalToConstant: 100)
            
            
        ])
    }
    
    
    
    
    
}
