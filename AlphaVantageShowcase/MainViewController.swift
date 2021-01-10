//
//  MainViewController.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInterfaceComponent()
        configureTabbar()
    }
    
    func configureInterfaceComponent() {
        view.backgroundColor = .white
    }
    
    func configureTabbar() {
        let intraDayVC = IntraDayViewController()
        intraDayVC.tabBarItem = UITabBarItem.init(title: "IntraDay", image: UIImage(systemName: "timer"), selectedImage: UIImage(systemName: "timer"))

        let dailyVC = DailyViewController()
        dailyVC.tabBarItem = UITabBarItem.init(title: "Daily", image: UIImage(systemName: "calendar"), selectedImage: UIImage(systemName: "calendar"))
        
        let configVC = ConfigureViewController()
        configVC.tabBarItem = UITabBarItem.init(title: "Setting", image: UIImage(named: "settings"), selectedImage: UIImage(named: "settings"))

        let tabBarList = [intraDayVC, dailyVC, configVC]
        viewControllers = tabBarList
    }
}
