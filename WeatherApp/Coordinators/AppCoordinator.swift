//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit

@MainActor
final class AppCoordinator:  Coordinator,  MainCoordinatorDelegate {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.coordinatorDelegate = self
        
        let mainView         = MainView()
        let mainVC           = MainViewController(mainView: mainView, mainViewModel: weatherViewModel)
        mainVC.title         = "Weather App"
        
        navigationController.isNavigationBarHidden = false
        navigationController.setViewControllers([mainVC], animated: false)
        
    }
    
    // MARK: - MainCoordinatorDelegate
    func didSelectWeatherData(_ weather: WeatherResponse) {
        
        let detailViewModel = DetailViewModel(weather: weather)
        let detailView      = DetailView()
        let detailVC        = DetailViewController(detailView: detailView, detailViewModel: detailViewModel)
        
        
        
        navigationController.pushViewController(detailVC, animated: true)
    }
}
