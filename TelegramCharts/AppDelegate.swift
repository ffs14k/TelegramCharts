//
//  AppDelegate.swift
//  TelegramCharts
//
//  Created by Eugene on 10/03/2019.
//  Copyright © 2019 Eugene. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        IntefaceUtils.uiMode = .light
        
        let root = StatisticsViewController()
        
        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        
        return true
    }

}

