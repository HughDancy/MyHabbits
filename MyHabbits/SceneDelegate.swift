//
//  SceneDelegate.swift
//  MyHabbits
//
//  Created by Борис Киселев on 05.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = .purple
        
        let firstViewController = HabitsViewController()
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        firstViewController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.split.1x2.fill"), tag: 0)
        
        let secondViewController = InformationViewController()
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        secondViewController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        
        tabBarController.setViewControllers([
        firstNavigationController,
        secondNavigationController],
        animated: true)
        
        
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

