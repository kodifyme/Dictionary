//
//  MainTabBarController.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    let translateView = TranslateBuilder.assembly()
    let historyView = UINavigationController(rootViewController: HistoryBuilder.assembly())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupTabBar()
    }
    
    private func setupAppearance() {
        tabBar.backgroundColor = .systemGray2
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.tintColor = .label
    }
    
    private func setupTabBar() {
        translateView.tabBarItem = UITabBarItem(title: "Translate", 
                                                image: UIImage(systemName: "globe"),
                                                tag: 0)
        historyView.tabBarItem = UITabBarItem(title: "History", 
                                              image: UIImage(systemName: "clock"),
                                              tag: 1)
        
        viewControllers = [translateView, historyView]
    }
}
