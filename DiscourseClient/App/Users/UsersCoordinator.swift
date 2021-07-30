//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class UsersCoordinator: Coordinator {
    var navigator: UINavigationController
    let userUseCases: UsersUseCases
    
    let remoteDataManager = RemoteDataManager()
    
    lazy var userDetailUseCases: UserDetailUseCases = DataManager(remoteDataManager: remoteDataManager)
    
    init(navigator: UINavigationController, userUseCases: UsersUseCases) {
        self.navigator = navigator
        self.userUseCases = userUseCases
    }
    
    // Inicializa model y pasa al controller el model
    func start() {
        let userViewModel = UsersViewModel(useCases: userUseCases)
        let userViewController = UsersViewController(viewModel: userViewModel)
        userViewController.title = "Usuarios"
        userViewModel.view = userViewController
        userViewModel.coordinator = self
        navigator.pushViewController(userViewController, animated: true)
    }
    
    // Navega e inicia la vista
    func didSelect(username: String) {
        let userDetailCoordinator = UserDetailCoordinator(navigator: navigator, username: username, useCases: userDetailUseCases)
        userDetailCoordinator.start()
    }
}
