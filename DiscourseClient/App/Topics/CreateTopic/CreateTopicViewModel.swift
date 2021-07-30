//
//  CreateTopicViewModel.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol CreateTopicViewProtocol {
    
}

class CreateTopicViewModel: ViewModel {
    typealias View = CreateTopicViewModel
    typealias Coordinator = CreateTopicCoordinator
    typealias UseCases = CreateTopicUseCases
    
    var view: CreateTopicViewModel?
    var coordinator: CreateTopicCoordinator?
    var useCases: UseCases
    
    // Comunicación con clousures
    var onCreateTopicSuccess: (() -> ())?
    var onCreateTopicFail: ((String) -> ())?
    //
    
    init(createTopicUseCases: CreateTopicUseCases) {
        useCases = createTopicUseCases
    }
    
    /**
     Al pulsar el botón
     */
    func onTapSubmitButton(title: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let createdAt = dateFormatter.string(from: Date())
        
        useCases.createTopic(title: title, raw: title, createdAt: createdAt) { [weak self] result in
            switch result {
            case .success:
                self?.onCreateTopicSuccess?()
            case .failure(let error):
                guard let responseError = error as? DiscourseClient.SessionAPIError else {
                    self?.onCreateTopicFail?("")
                    return
                }
                var message = error.localizedDescription
                
                switch responseError {
                case .apiError(let msg): message = msg.errors?.first ?? error.localizedDescription
                case .httpError(let code): message = "Error code: \(code)"
                }
                self?.onCreateTopicFail?(message)
            }
        }
    }
}

