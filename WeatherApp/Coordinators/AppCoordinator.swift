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
        
        let detailViewModel = DetailViewModel()

        let mainView = MainView()
        let detailView = DetailView()
        
        tabBarCoordinator = TabBarCoordinator(
            navigationController: navigationController,
            mainViewModel: weatherViewModel,
            mainView: mainView,
            detailView: detailView,
            detailViewModel: detailViewModel
            
        )
        
        tabBarCoordinator?.start()
    }
}
