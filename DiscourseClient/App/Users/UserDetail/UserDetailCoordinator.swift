//
//  UserDetailCoordinator.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class UserDetailCoordinator: Coordinator {
    var navigator: UINavigationController
    let username: String
    let useCases: UserDetailUseCases
    
    init(navigator: UINavigationController, username: String, useCases: UserDetailUseCases) {
        self.navigator = navigator
        self.username = username
        self.useCases = useCases
    }
    
    func start() {
        let userDetailViewModel = UserDetailViewModel(username: username, userDetailUseCases: useCases)
        let userDetailViewController = UserDetailViewController(viewModel: userDetailViewModel)
        userDetailViewModel.view = userDetailViewController
        userDetailViewModel.coordinator = self
        userDetailViewController.title = "Datos del usuario"
        navigator.pushViewController(userDetailViewController, animated: false)
    }
}
