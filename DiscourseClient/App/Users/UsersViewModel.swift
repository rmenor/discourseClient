//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import Foundation

// Se avisa a la vista por medio de un protocolo
protocol UsersViewProtocol: AnyObject {
    func usersFetched()
    func errorFetchingUsers()
}

class UsersViewModel: ViewModel {
    typealias View = UsersViewProtocol
    typealias Coordinator = UsersCoordinator
    typealias UseCases = UsersUseCases

    weak var view: View? // Se añade el weak para que se puedan eliminar
    var coordinator: Coordinator?
    var useCases: UseCases
    
    var userCellViewModels: [UserCellViewModel] = []
    
    init(useCases: UsersUseCases) {
        self.useCases = useCases
    }
    
    func viewDidLoad() {
        self.fetchAllUsers()
    }
    
    // Cantidad
    func numberOfRows(in section: Int) -> Int {
        return userCellViewModels.count
    }
    
    // Sección 1
    func numberOfSections() -> Int {
        return 1
    }
    
    // Los datos
    func cellViewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userCellViewModels.count else {return nil}
        return userCellViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator?.didSelect(username: userCellViewModels[indexPath.row].user.username)
    }
    
    func fetchAllUsers() {
        useCases.fetchAllUsers {[weak self] result in
            switch result {
            case .success(let response):
                guard let response = response else {self?.view?.errorFetchingUsers(); return}
                self?.userCellViewModels = response.directoryItems.map{ UserCellViewModel(user: $0.user) }
                self?.view?.usersFetched()
            case .failure:
                self?.view?.errorFetchingUsers()
            }
        }
    }
}
