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
        intraDayVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let dailyVC = DailyViewController()
        dailyVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        let tabBarList = [intraDayVC, dailyVC]
        viewControllers = tabBarList
    }
}
