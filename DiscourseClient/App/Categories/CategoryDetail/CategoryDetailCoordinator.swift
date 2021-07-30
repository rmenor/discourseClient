//
//  CategoryDetailCoordinator.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CategoryDetailCoordinator: Coordinator {
    var navigator: UINavigationController
    let categoryId: Int
    let useCases: CategoryDetailUseCases
    
    init(navigator: UINavigationController, categoryId: Int, useCases: CategoryDetailUseCases) {
        self.navigator = navigator
        self.categoryId = categoryId
        self.useCases = useCases
    }
    
    func start() {
        let categoryDetailViewModel = CategoryDetailViewModel(categoryId: categoryId, useCases: useCases)
        let categoryDetailViewController = CategoryDetailViewController(viewModel: categoryDetailViewModel)
        categoryDetailViewController.title = "Category detail"
        //topicDetailViewModel.view = topicDetailViewController
        categoryDetailViewModel.coordinator = self
        
        navigator.pushViewController(categoryDetailViewController, animated: true)
    }
}
