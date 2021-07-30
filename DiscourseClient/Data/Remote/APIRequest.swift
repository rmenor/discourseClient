//
//  APIRequest.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

//fileprivate let apiURL = "https://mdiscourse.keepcoding.io" // Solo accesible en este fichero

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIRequest {
    associatedtype Response : Codable
    var method: Method { get } // Definimos get solo lectura se puede poner { get set }
    var path: String { get }
    var parameters: [String:String] { get }
    var body: [String:Any] { get }
    var headers: [String:String] { get }
}

extension APIRequest {
    
    // Esto es lo mismo que el apiURL comentado arriba
    var apiURL : String {
        return "https://mdiscourse.keepcoding.io"
    }
    
    var baseURL: URL {
        guard let baseURL = URL(string: apiURL) else {
            fatalError("Url no válida")
        }
        return baseURL
    }
    
    func requestWithBaseUrl() -> URLRequest {
        // Definimos cual va a ser la url
        let url = baseURL.appendingPathComponent(path)
        // Aquí tendríamos www.google.com/search
        
        // Si tiene parámetros
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("No hay parámetros")
        }
        
        if !parameters.isEmpty {
            components.queryItems = parameters.map{key, value in URLQueryItem(name: key, value: value)}
        }
        
        guard let finalUrl = components.url else {
            fatalError("NO hay url")
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        
        if !body.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-key")
        
        request.addValue("che1404", forHTTPHeaderField: "Api-Username")
        
        return request
    }
}
