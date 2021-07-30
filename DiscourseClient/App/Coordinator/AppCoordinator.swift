//
//  AppCoordinator.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

protocol Coordinator {
    var navigator: UINavigationController {get}
    
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        navigator.dismiss(animated: true, completion: nil)
    }
}

class AppCoordinator: Coordinator {
    var navigator: UINavigationController = UINavigationController()
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    var dataManager = DataManager(remoteDataManager: RemoteDataManager())
    
    func start() {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        
        // Añade el botón de usuarios
        let usersNavigator = UINavigationController()
        let usersCoordinator = UsersCoordinator(navigator: usersNavigator, userUseCases: dataManager)
        usersCoordinator.start()
        
        // Añade el botón de topics
        let topicsNavigator = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(navigator: topicsNavigator, topicsUseCase: dataManager)
        topicsCoordinator.start()
        
        //viewcontrollers del tabbar
        tabBarController.viewControllers = [usersNavigator, topicsNavigator]
        tabBarController.tabBar.items?.first?.image = UIImage(systemName: "tag")
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "list.dash")
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
