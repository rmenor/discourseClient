//
//  ViewModel.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

protocol ViewModel {
    associatedtype View // La vista será un protocolo
    associatedtype Coordinator // será el propio coordinator
    associatedtype UseCases
    
    var view: View? { get } // Hay que poner weak para que se pueda destruir
    var coordinator: Coordinator? { get }
    var useCases: UseCases { get }
}
