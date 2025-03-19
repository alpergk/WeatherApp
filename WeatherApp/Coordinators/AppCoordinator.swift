//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit

class AppCoordinator: @preconcurrency Coordinator {
    
    var navigationController: UINavigationController
    var tabBarCoordinator: TabBarCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor func start() {
        let weatherViewModel = WeatherViewModel()
//        let weatherSearchView = WeatherSearchView()
        let mainView = MainView()
        
        tabBarCoordinator = TabBarCoordinator(
            navigationController: navigationController,
            mainViewModel: weatherViewModel,
            /*weatherSearchView: weatherSearchView,*/ mainView: mainView
        )
        
        tabBarCoordinator?.start()
    }
}
