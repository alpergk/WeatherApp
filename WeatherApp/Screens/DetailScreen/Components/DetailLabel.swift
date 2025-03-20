//
//  DetailLabel.swift
//  WeatherApp
//
//  Created by Alper Gok on 20.03.2025.
//

import UIKit

class DetailLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment = .left,
                     textColor: UIColor = .red,
                     textStyle: UIFont.TextStyle = .body,
                     customSize: CGFloat? = nil) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = textAlignment
        self.textColor = textColor
        
        let baseFont = UIFont.preferredFont(forTextStyle: textStyle)
        let fontToUse: UIFont
        
        // If customSize is provided, override the font size.
        if let size = customSize {
            let customFont = baseFont.withSize(size)
            fontToUse = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: customFont)
        } else {
            fontToUse = baseFont
        }
        
        self.font = fontToUse
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.75
        lineBreakMode             = .byWordWrapping
        
        
        
    }
}
