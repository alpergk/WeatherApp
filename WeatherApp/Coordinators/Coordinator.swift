//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Alper Gok on 13.03.2025.
//

import UIKit

protocol Coordinator {
    @MainActor var navigationController: UINavigationController { get set }
    @MainActor func start()
}
