//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

// Comunica el viewmodel con la view
protocol TopicsViewProtocol: AnyObject {
    func topicsFectched()
    func errorFetchingTopics()
}

class TopicsViewModel: ViewModel {
    typealias View = TopicsViewProtocol
    
    typealias Coordinator = TopicsCoordinator
    
    typealias UseCases = TopicsUseCases
    
    weak var view: TopicsViewProtocol?
    
    var coordinator: Coordinator?
    
    var useCases: UseCases
    
    init(useCases: TopicsUseCases) {
        self.useCases = useCases
    }
    
    func viewDidLoad() {
        useCases.fetchAllTopics { [weak self]  result in
            switch result {
            case .success(let response):
                guard let topics = response?.topicList.topics else { return }
                self?.topicsCellViewModel = topics.map{ TopicCellViewModel(topic: $0)}
                self?.view?.topicsFectched()
            case .failure:
                self?.view?.errorFetchingTopics()
            }
        }
    }
    
    var topicsCellViewModel: [TopicCellViewModel] = []
    
    // Cantidad de celdas
    func numberOfRows(in section: Int) -> Int {
        return topicsCellViewModel.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicsCellViewModel.count else { return nil }
        return topicsCellViewModel[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator?.didSelect(topic: topicsCellViewModel[indexPath.row].topic)
    }
    
    func onTapAddButton() {
        coordinator?.onTapAddButton()
    }
}
