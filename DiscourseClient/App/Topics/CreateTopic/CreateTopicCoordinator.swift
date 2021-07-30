//
//  CreateTopicCoordinator.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CreateTopicCoordinator: Coordinator {
    var navigator: UINavigationController
    let createTopicUseCases: CreateTopicUseCases
    
    init(navigator: UINavigationController, createTopicUseCases: CreateTopicUseCases) {
        self.navigator = navigator
        self.createTopicUseCases = createTopicUseCases
    }
    
    func start() {
        let createTopicViewModel = CreateTopicViewModel(createTopicUseCases: createTopicUseCases)
        let createTopicViewController = CreateTopicViewController(viewModel: createTopicViewModel)
        
        // NO hace falta porque lo vamos a implementar con clousures
        //createTopicViewModel.view = createTopicViewController
        createTopicViewModel.coordinator = self
        createTopicViewController.title = "Añadir título"
        
        let navigationController = UINavigationController(rootViewController: createTopicViewController)
        navigator.present(navigationController, animated: true)
    }
}
