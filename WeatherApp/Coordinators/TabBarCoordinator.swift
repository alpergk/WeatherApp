//
//  TabBarCoordinator.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit



class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController() //
    }
    
    func start() {
        let homeScreenNC = createHomeScreenNC()
        tabBarController.viewControllers = [homeScreenNC]
        tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    private func createHomeScreenNC() -> UINavigationController {
        let homeScreenVC = WeatherView()
        homeScreenVC.title = "Home"
        homeScreenVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        return UINavigationController(rootViewController: homeScreenVC)
    }
}
