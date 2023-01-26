//
//  AppDelegate.swift
//  MyHabbits
//
//  Created by Борис Киселев on 05.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        
        let firstViewController = HabitsViewController()
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        firstViewController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.split.1x2.fill"), tag: 0)
        
        let secondViewController = InformationViewController()
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        secondViewController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        tabBarController.setViewControllers([
        firstNavigationController,
        secondNavigationController], animated: true)
        
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

