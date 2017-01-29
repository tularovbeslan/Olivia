//
//  AppDelegate.swift
//  Olivia
//
//  Created by BESLAN TULAROV on 11.01.17.
//  Copyright © 2017 BESLAN TULAROV. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        navigationBarConfigure()
        return true
    }

    //MARK: - UINavigationBar appearance
    func navigationBarConfigure() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage    = UIImage()
        UINavigationBar.appearance().barTintColor   = UIColor(red:0.13, green:0.13, blue:0.12, alpha:1.00)
        UINavigationBar.appearance().isTranslucent  = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName: UIFont(name: "perfectlyamicable", size: 24)!]
    }
}


