//
//  MainTabBarController.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    let translateView = TranslateBuilder.assembly()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupTabBar()
    }
    
    private func setupAppearance() {
        tabBar.backgroundColor = .systemGray2
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .white
    }
    
    private func setupTabBar() {
        translateView.tabBarItem = UITabBarItem(title: "Translate", image: UIImage(systemName: "globe"), tag: 0)
        
        viewControllers = [translateView]
    }
}
