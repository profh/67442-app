//
//  TabBarViewController.swift
//  PersonalCaddie
//
//  Created by Philip Baker on 12/3/18.
//  Copyright © 2018 67442. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().unselectedItemTintColor = UIColor( red: CGFloat(70/255.0), green: CGFloat(70/255.0), blue: CGFloat(70/255.0), alpha: CGFloat(1) )
        UITabBar.appearance().tintColor = .black

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
