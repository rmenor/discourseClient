//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

// Comunica el viewmodel con la view
protocol CategoriesViewProtocol: AnyObject {
    func categoriesFectched()
    func errorFetchingCategories()
}

class CategoriesViewModel: ViewModel {
    typealias View = CategoriesViewProtocol
    
    typealias Coordinator = CategoriesCoordinator
    
    typealias UseCases = CategoriesUseCases
    
    weak var view: CategoriesViewProtocol?
    
    var coordinator: Coordinator?
    
    var useCases: UseCases
    
    init(useCases: CategoriesUseCases) {
        self.useCases = useCases
    }
    
    func viewDidLoad() {
        useCases.fetchAllCategories { [weak self]  result in
            switch result {
            case .success(let response):
                guard let categories = response?.categoryList.categories else { return }
                self?.categoriesCellViewModel = categories.map{ CategoryCellViewModel(category: $0)}
                self?.view?.categoriesFectched()
                return
            case .failure:
                self?.view?.errorFetchingCategories()
                return
            }
        }
    }
    
    var categoriesCellViewModel: [CategoryCellViewModel] = []
    
    // Cantidad de celdas
    func numberOfRows(in section: Int) -> Int {
        return categoriesCellViewModel.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CategoryCellViewModel? {
        guard indexPath.row < categoriesCellViewModel.count else { return nil }
        return categoriesCellViewModel[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator?.didSelect(category: categoriesCellViewModel[indexPath.row].category)
    }
    
    func onTapAddButton() {
        coordinator?.onTapAddButton()
    }
    
    func getColor(color: String) -> UIColor {
        return UIColor(hexaString: color)
    }
}
