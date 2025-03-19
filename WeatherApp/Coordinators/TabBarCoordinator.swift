//
//  TabBarCoordinator2.swift
//  WeatherApp
//
//  Created by Alper Gok on 18.03.2025.
//

import Foundation
import UIKit

class TabBarCoordinator: @preconcurrency Coordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    //var weatherViewModel: WeatherViewModel
    //var weatherSearchView: WeatherSearchView
    var mainView : MainView
    var mainViewModel: WeatherViewModel
    
    init(navigationController: UINavigationController, mainViewModel: WeatherViewModel, /*weatherSearchView: WeatherSearchView,*/ mainView: MainView) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
        self.mainViewModel = mainViewModel
        //self.weatherSearchView = weatherSearchView
        self.mainView = mainView
    }
    
    @MainActor func start() {
//        let homeScreenNC = createHomeScreenNC()
        let favScreenNC = createFavoriteScreenNC()
        let mainScreenNC = createMainScreenNC()
        mainScreenNC.navigationBar.prefersLargeTitles = true
        tabBarController.viewControllers = [mainScreenNC,favScreenNC]
        tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
//    @MainActor private func createHomeScreenNC() -> UINavigationController {
//        let homeScreenVC = WeatherSearchViewController(viewModel: weatherViewModel, searchView: weatherSearchView)
//        homeScreenVC.title = "Home"
//        homeScreenVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
//        return UINavigationController(rootViewController: homeScreenVC)
//    }
    
    private func createFavoriteScreenNC() -> UINavigationController {
        let favScreenVC = FavoriteView()
        favScreenVC.title = "Favorites"
        favScreenVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "start.fill"))
        return UINavigationController(rootViewController: favScreenVC)
    }
    
    private func createMainScreenNC() -> UINavigationController {
        let mainScreenVC = MainViewController(mainView: mainView, mainViewModel: mainViewModel)
        mainScreenVC.title = "Weather App"
        mainScreenVC.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        return UINavigationController(rootViewController: mainScreenVC)
    }
    
    
}
