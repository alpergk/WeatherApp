//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Alper Gok on 15.03.2025.
//

import Foundation
import CoreLocation
import UIKit


final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    static let shared = LocationManager()
    
    private var locationFetchHandler: ((CLLocation) -> Void)?
    
    private var location: CLLocation? {
        didSet {
            guard let location else { return }
            locationFetchHandler?(location)
            locationFetchHandler = nil
        }
    }
    
    private override init() {
        super.init()
        manager.delegate = self
    }
    
    public func getCurrentLocation(completion: @escaping (Double, Double) -> Void) {
        self.locationFetchHandler = { location in
            let latitude  = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            completion(latitude, longitude)
        }
        
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization() 
        } else {
            manager.startUpdatingLocation()
        }
    }
    
    
    // MARK: - Handle Location Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.location = location
        manager.stopUpdatingLocation()
    }
    
    
    // MARK: - Handle Authorization Changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .restricted:
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "Location Access Denied",
                    message: "Please enable location services in Settings to use this feature.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
                    if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                })
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let rootViewController = windowScene.windows.first?.rootViewController {
                    rootViewController.present(alert, animated: true)
                }
            }
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
