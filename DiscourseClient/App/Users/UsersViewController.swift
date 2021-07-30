//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class UsersViewController: UIViewController {
    
    let viewModel: UsersViewModel
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        // Creamos la vista
        view = UIView()
        view.backgroundColor = .white
        
        // Añadimos la tabla a la vista
        view.addSubview(tableView)
        
        // Constrains de la tabla con respecto a la vista
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

      // Cuando se crea la clase y se carga el xib
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel.viewDidLoad()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
//            self.showLoader()
//        }
//    }

    // Justo antes de que aparezca la vista
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            self.showLoader()
        }
        viewModel.fetchAllUsers()
    }
    
    private func showErrorFechingUsers() {
        showAlert(title: "Error feching users", message: "")
    }
}

extension UsersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell {
            let cellViewModel = viewModel.cellViewModel(at: indexPath)
            cell.viewModel = cellViewModel
            
            return cell
        }
        fatalError()
    }
}

extension UsersViewController: UITableViewDelegate {
    // Pulsar un celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension UsersViewController: UsersViewProtocol {
    func usersFetched() {
        hideLoader()
        tableView.reloadData()
    }
    
    func errorFetchingUsers() {
        hideLoader()
        showErrorFechingUsers()
    }
}
