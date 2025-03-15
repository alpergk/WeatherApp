//
//  BaseCoordinator.swift
//  WeatherApp
//
//  Created by Alper Gok on 14.03.2025.
//

import Foundation

class BaseCoordinator: Coordinator1 {
    
    var childCoordinators: [any Coordinator1] = []
    var child1Coordinators: [Coordinator1] = []
    func start() {
        
    }
    
    func addChild(_coordinator: Coordinator) {
        
    }
    
    
}
