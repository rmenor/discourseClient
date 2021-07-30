//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol TopicDetailViewProtocol: AnyObject {}

struct TopicDetailViewStruct {
    let topicId: String
    let topicName: String
    let postNumber: String
    let topicCanBeDeleted: Bool
}

class TopicDetailViewModel: ViewModel {
    typealias View = TopicDetailViewProtocol
    typealias Coordinator = TopicsDetailCoordinator
    typealias UseCases = TopicDetailUseCases

    var view: TopicDetailViewProtocol? // no lo vamos a utilizar porque usarmos clusures
    var coordinator: TopicsDetailCoordinator?
    var useCases: UseCases
    
    let topicId: Int
    
    // Comunicación con clousures
    var onGetTopicSuccess: ((TopicDetailViewStruct) -> ())?
    var onGetTopicFail: (() -> ())?
    //
    
    init(topicId: Int, useCases: TopicDetailUseCases) {
        self.topicId = topicId
        self.useCases = useCases
    }
    
    func viewDidLoad() {
        useCases.fetchTopic(id: topicId) { [weak self] result in
            switch result {
            case .success(let response):
                guard let response = response else {return}
                let topicDetailViewStruct = TopicDetailViewStruct(topicId: "\(response.id)", topicName: response.title, postNumber: "\(response.postsCount)", topicCanBeDeleted: response.details.canDelete ?? false)
                self?.onGetTopicSuccess?(topicDetailViewStruct)
            case .failure:
                self?.onGetTopicFail?()
            }
        }
    }
    
    // Comunicación con clousures
    var onDeleteSuccess: (() -> ())?
    var onDeleteFail: ((String) -> ())?
    // Después hay que crear en el controller los bindViewModel que escuchan
    //
    
    func onTabDeleteButton(){
        useCases.deleteTopic(id: topicId) { [weak self] result in
            switch result {
            case .success:
                self?.coordinator?.ondDeleteTopicSuccess()
                self?.onDeleteSuccess?()
            case .failure(let error):
                guard let responseError = error as? DiscourseClient.SessionAPIError else {
                    self?.onDeleteFail?("")
                    return
                }
                var message = error.localizedDescription
                
                switch responseError {
                case .apiError(let msg): message = msg.errors?.first ?? error.localizedDescription
                case .httpError(let code): message = "Error code: \(code)"
                }
                self?.onDeleteFail?(message)
            }
        }
    }
}
