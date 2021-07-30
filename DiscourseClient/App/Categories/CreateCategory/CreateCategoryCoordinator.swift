//
//  CreateCategoryCoordinator.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CreateCategoryCoordinator: Coordinator {
    var navigator: UINavigationController
    let createCategoryUseCases: CreateCategoryUseCases
    
    init(navigator: UINavigationController, createCategoryUseCases: CreateCategoryUseCases) {
        self.navigator = navigator
        self.createCategoryUseCases = createCategoryUseCases
    }
    
    func start() {
        let createCategoryViewModel = CreateCategoryViewModel(createCategoryUseCases: createCategoryUseCases)
        let createCategoryViewController = CreateCategoryViewController(viewModel: createCategoryViewModel)
        
        // NO hace falta porque lo vamos a implementar con clousures
        //createTopicViewModel.view = createTopicViewController
        createCategoryViewModel.coordinator = self
        createCategoryViewController.title = "Añadir categoría"
        
        let navigationController = UINavigationController(rootViewController: createCategoryViewController)
        navigator.present(navigationController, animated: true)
    }
}
