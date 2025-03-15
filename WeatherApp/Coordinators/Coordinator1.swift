//
//  Coordinator1.swift
//  WeatherApp
//
//  Created by Alper Gok on 14.03.2025.
//

import Foundation

protocol Coordinator1 {
    var childCoordinators: [Coordinator1] { get set }
    func start()
}
