//
//  TabBarController.swift
//  BallOfTruth
//
//  Created by Илья on 25.01.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        
        let mainNavigationController = UINavigationController()
        mainNavigationController.viewControllers = [MainViewController()]
        mainNavigationController.title = "Main"
        mainNavigationController.tabBarItem.image = UIImage(systemName: "tag")
        mainNavigationController.tabBarItem.selectedImage = UIImage(systemName: "tag.fill")
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.viewControllers = [SettingsViewController()]
        settingsNavigationController.title = "Settings"
        settingsNavigationController.tabBarItem.image = UIImage(systemName: "gearshape")
        settingsNavigationController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
        self.setViewControllers([mainNavigationController, settingsNavigationController], animated: false)
    }
}
