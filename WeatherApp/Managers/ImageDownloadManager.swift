//
//  ImageDownloadManager.swift
//  WeatherApp
//
//  Created by Alper Gok on 23.03.2025.
//

import UIKit

final class ImageDownloadManager {
    
    public static let shared = ImageDownloadManager()
    
    private init() {}
    
    
    func downloadImage(for iconCode: String) async -> UIImage {
        let urlString = Constants.downloadImageBaseURL + iconCode + "@2x.png"
        guard let url = URL(string: urlString) else {
            return UIImage()
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let image = UIImage(data: data) {
                return image
            } else {
                return UIImage()
            }
        } catch {
            print("Failed to download image: \(error)")
            return UIImage()
        }
        
    }
}
