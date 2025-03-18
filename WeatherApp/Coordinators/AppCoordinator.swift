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
        tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator?.start()
    }
    
  
    

    
    
    
}
