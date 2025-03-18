//
//  TabBarCoordinator.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit



class TabBarCoordinator: @preconcurrency Coordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    @MainActor func start() {
        let homeScreenNC = createHomeScreenNC()
        tabBarController.viewControllers = [homeScreenNC]
        tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    @MainActor private func createHomeScreenNC() -> UINavigationController {
        
        let viewModel = WeatherViewModel()
        let searchView = WeatherSearchView()
        
        let homeScreenVC = WeatherView(viewModel: viewModel, searchView: searchView)
        homeScreenVC.title = "Home"
        homeScreenVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        return UINavigationController(rootViewController: homeScreenVC)
    }
}
