//
//  CategoryDetailViewModel.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

protocol CategoryDetailViewProtocol: AnyObject {}

struct CategoryDetailViewStruct {
    let categoryId: String
    let categoryName: String?
    let categoryColor: String?
}

class CategoryDetailViewModel: ViewModel {
    typealias View = CategoryDetailViewProtocol
    typealias Coordinator = CategoryDetailCoordinator
    typealias UseCases = CategoryDetailUseCases
    
    var view: CategoryDetailViewProtocol?
    var coordinator: CategoryDetailCoordinator?
    var useCases: CategoryDetailUseCases
    
    let categoryId: Int
    
    var onGetCategorySuccess: ((CategoryDetailViewStruct) -> ())?
    var onGetCategoryFail: (() -> ())?
    
    init(categoryId: Int, useCases: CategoryDetailUseCases) {
        self.categoryId = categoryId
        self.useCases = useCases
    }
    
    func viewDidLoad() {
        useCases.fetchCategory(id: categoryId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let response = response else {return}
                let categoryDetailViewStruct = CategoryDetailViewStruct(categoryId: "\(response.category.id)", categoryName: response.category.name, categoryColor: response.category.color)
                self?.onGetCategorySuccess?(categoryDetailViewStruct)
            case .failure:
                self?.onGetCategoryFail?()
            }
        }
    }
    
    func getColor(color: String) -> UIColor {
        return UIColor(hexaString: color)
    }
}
