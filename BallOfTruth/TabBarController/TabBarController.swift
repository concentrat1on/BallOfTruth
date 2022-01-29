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
        // Do any additional setup after loading the view.
    }
    
    func setupTabBar() {
        
        let mainNavController = UINavigationController()
        mainNavController.viewControllers = [MainViewController()]
        mainNavController.title = "Main"
        mainNavController.tabBarItem.image = UIImage(systemName: "tag")
        mainNavController.tabBarItem.selectedImage = UIImage(systemName: "tag.fill")
        let settingsNavController = UINavigationController()
        settingsNavController.viewControllers = [SettingsViewController()]
        settingsNavController.title = "Settings"
        settingsNavController.tabBarItem.image = UIImage(systemName: "gearshape")
        settingsNavController.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
        self.setViewControllers([mainNavController, settingsNavController], animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
