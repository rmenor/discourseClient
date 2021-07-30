//
//  CreateCategoryViewModel.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol CreateCategoryViewProtocol {
    
}

class CreateCategoryViewModel: ViewModel {
    typealias View = CreateCategoryViewModel
    typealias Coordinator = CreateCategoryCoordinator
    typealias UseCases = CreateCategoryUseCases
    
    var view: CreateCategoryViewModel?
    var coordinator: CreateCategoryCoordinator?
    var useCases: UseCases
    
    // Comunicación con clousures
    var onCreateCategorySuccess: (() -> ())?
    var onCreateCategoryFail: ((String) -> ())?
    //
    
    init(createCategoryUseCases: CreateCategoryUseCases) {
        useCases = createCategoryUseCases
    }
    
    /**
     Al pulsar el botón
     */
    func onTapSubmitButton(name: String, color: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let createdAt = dateFormatter.string(from: Date())
        
        useCases.createCategory(name: name, color: color, createdAt: createdAt) { [weak self] result in
            switch result {
            case .success:
                self?.onCreateCategorySuccess?()
            case .failure(let error):
                guard let responseError = error as? DiscourseClient.SessionAPIError else {
                    self?.onCreateCategoryFail?("")
                    return
                }
                var message = error.localizedDescription
                
                switch responseError {
                case .apiError(let msg): message = msg.errors?.first ?? error.localizedDescription
                case .httpError(let code): message = "Error code: \(code)"
                }
                self?.onCreateCategoryFail?(message)
            }
        }
    }
}
