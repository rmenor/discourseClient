//
//  TopicDetailCoordinator.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class TopicsDetailCoordinator: Coordinator {
    var navigator: UINavigationController
    let topicId: Int
    let useCases: TopicDetailUseCases
    
    init(navigator: UINavigationController, topicId: Int, useCases: TopicDetailUseCases) {
        self.navigator = navigator
        self.topicId = topicId
        self.useCases = useCases
    }
    
    func start() {
        let topicDetailViewModel = TopicDetailViewModel(topicId: topicId, useCases: useCases)
        let topicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
        topicDetailViewController.title = "Topic detail"
        //topicDetailViewModel.view = topicDetailViewController
        topicDetailViewModel.coordinator = self
        
        navigator.pushViewController(topicDetailViewController, animated: true)
    }
    
    func ondDeleteTopicSuccess() {
        navigator.popViewController(animated: false)
    }
}
