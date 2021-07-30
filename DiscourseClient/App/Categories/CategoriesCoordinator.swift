//
//  CategoriesCoordinator.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CategoriesCoordinator: Coordinator {
    var navigator: UINavigationController
    
    let categoriesUseCase: CategoriesUseCases
    let categoryDetailUseCases: CategoryDetailUseCases = DataManager(remoteDataManager: RemoteDataManager())
    
    init(navigator: UINavigationController, categoriesUseCase: CategoriesUseCases) {
        self.navigator = navigator
        self.categoriesUseCase = categoriesUseCase
    }
    
    func start() {
        let categoriesViewModel = CategoriesViewModel(useCases: categoriesUseCase)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        categoriesViewController.title = "Categorías"
        categoriesViewModel.view = categoriesViewController
        categoriesViewModel.coordinator = self
        navigator.pushViewController(categoriesViewController, animated: false)
    }
    
    // Navega e inicia la vista
    func didSelect(category: Category) {
        let categoryDetailCoordinator = CategoryDetailCoordinator(navigator: navigator, categoryId: category.id, useCases: categoryDetailUseCases)
        categoryDetailCoordinator.start()
    }
    
    func onTapAddButton() {
        
    }
}
