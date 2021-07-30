//
//  TopicsCoordinator.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class TopicsCoordinator: Coordinator {
    var navigator: UINavigationController
    
    let topicsUseCase: TopicsUseCases
    let topicDetailUseCases: TopicDetailUseCases = DataManager(remoteDataManager: RemoteDataManager())
    
    init(navigator: UINavigationController, topicsUseCase: TopicsUseCases) {
        self.navigator = navigator
        self.topicsUseCase = topicsUseCase
    }
    
    func start() {
        let topicsViewModel = TopicsViewModel(useCases: topicsUseCase)
        let topicsViewController = TopicsViewController(viewModel: topicsViewModel)
        topicsViewController.title = "Topics"
        topicsViewModel.view = topicsViewController
        topicsViewModel.coordinator = self
        navigator.pushViewController(topicsViewController, animated: false)
    }
    
    // Navega e inicia la vista
    func didSelect(topic: Topic) {
        let topicsDetailCoordinator = TopicsDetailCoordinator(navigator: navigator, topicId: topic.id, useCases: topicDetailUseCases)
        topicsDetailCoordinator.start()
    }
    
    func onTapAddButton() {
        let createTopicCoordinator = CreateTopicCoordinator(navigator: navigator, createTopicUseCases: DataManager(remoteDataManager: RemoteDataManager()))
        createTopicCoordinator.start()
    }
}
