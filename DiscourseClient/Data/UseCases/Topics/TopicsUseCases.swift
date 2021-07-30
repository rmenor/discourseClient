//
//  TopicsUseCases.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol TopicsUseCases {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ())
}

extension DataManager: TopicsUseCases {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllTopics(completion: completion)
    }
}

extension RemoteDataManager: TopicsUseCases {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.request(request: request, completion: completion)
    }
}
