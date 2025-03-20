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
    var mainView : MainView
    var mainViewModel: WeatherViewModel
    var detailView: DetailView
    var detailViewModel: DetailViewModel
    
    init(navigationController: UINavigationController, mainViewModel: WeatherViewModel,mainView: MainView, detailView: DetailView, detailViewModel: DetailViewModel) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
        self.mainViewModel = mainViewModel
        self.detailView = detailView
        self.detailViewModel = detailViewModel
        self.mainView = mainView
    }
    
    @MainActor func start() {

        let favScreenNC = createFavoriteScreenNC()
        let mainScreenNC = createMainScreenNC()
        let detailScreenNC = createDetailScreenNC()
        mainScreenNC.navigationBar.prefersLargeTitles = true
        tabBarController.viewControllers = [mainScreenNC,detailScreenNC]
        tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    
    private func createFavoriteScreenNC() -> UINavigationController {
        let favScreenVC = FavoriteView()
        favScreenVC.title = "Favorites"
        favScreenVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "start.fill"))
        return UINavigationController(rootViewController: favScreenVC)
    }
    
    private func createDetailScreenNC() -> UINavigationController {
        let detailScreenVC = DetailViewController(detailView: detailView, detailViewModel: detailViewModel)
        detailScreenVC.title = "xx"
        detailScreenVC.tabBarItem = UITabBarItem(title: "xx", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        return UINavigationController(rootViewController: detailScreenVC)
    }
    
    private func createMainScreenNC() -> UINavigationController {
        let mainScreenVC = MainViewController(mainView: mainView, mainViewModel: mainViewModel)
        mainScreenVC.title = "Weather App"
        mainScreenVC.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        return UINavigationController(rootViewController: mainScreenVC)
    }
    
    
}
