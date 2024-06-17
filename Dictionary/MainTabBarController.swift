//
//  MainTabBarController.swift
//  Dictionary
//
//  Created by KOДИ on 17.06.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    let translateView = TranslateView()
    let historyView = HistoryView()
    let settingsView = SettingsView()
    
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
        historyView.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock"), tag: 1)
        settingsView.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape")?.withTintColor(.white), tag: 2)
        
        viewControllers = [translateView, historyView, settingsView]
    }
}
