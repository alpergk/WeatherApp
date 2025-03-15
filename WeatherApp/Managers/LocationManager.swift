//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Alper Gok on 15.03.2025.
//

import Foundation
import CoreLocation


final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    static let shared = LocationManager()
    
    private var locationFetchCompletion: ((CLLocation) -> Void)?
    
    private var location: CLLocation? {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("LocationUpdated"), object: nil)
            guard let location else { return }
            locationFetchCompletion?(location)
            
        }
    }
    
    private override init() {
        super.init()
        manager.delegate = self
    }
    
    public func getCurrentLocation(completion: @escaping (Double, Double) -> Void) {
        self.locationFetchCompletion = { location in
            let latitude  = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            completion(latitude, longitude)
        }
        
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization() // Triggers `locationManagerDidChangeAuthorization`
        } else {
            manager.startUpdatingLocation() // If already authorized, start updating
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
              manager.startUpdatingLocation()
          case .denied, .restricted:
              print("Location access denied or restricted. Please enable it in Settings.")
          default:
              break
          }
      }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
