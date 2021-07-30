//
//  SessionAPI.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

enum SessionAPIError: Error {
    case httpError(Int)
    case apiError(ApiError)
}

struct ApiError: Codable {
    let action: String?
    let errors: [String]?
}

final class SessionAPI {
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        return session
    }()
    
    func request<T: APIRequest> (request: T, completion: @escaping(Result<T.Response?, Error>) -> ()) {
        let request = request.requestWithBaseUrl()

        let task = session.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(ApiError.self, from: data)
                        DispatchQueue.main.async {
                            completion(.failure(SessionAPIError.apiError(model)))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(SessionAPIError.httpError(httpResponse.statusCode)))
                    }
                }
            }
            
            // Si nos devuelve ok
            if let data = data, data.count > 0 {
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(nil))
                }
            }
        }
        
        task.resume()
    }
}
