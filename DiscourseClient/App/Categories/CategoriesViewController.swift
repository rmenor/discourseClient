//
//  CategoriesViewController.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CategoriesViewController: UIViewController {
    let viewModel: CategoriesViewModel
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    init(viewModel: CategoriesViewModel) {
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
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(onTapAddButton))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            self.showLoader()
        }
        viewModel.viewDidLoad()
    }
    
    private func onCategoriesFetched() {
        hideLoader()
        tableView.reloadData()
    }
    
    private func onCategoriesFetchError() {
        hideLoader()
        showAlert(title: "Error al recibir las categorías", message: "")
    }
    
    @objc private func onTapAddButton() {
        //showAlert(title: "Acción no disponible en estos momentos.", message: "")
        viewModel.onTapAddButton()
    }
    
    // Justo antes de que aparezca la vista
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            self.showLoader()
        }
        viewModel.viewDidLoad()
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell, let cellViewModel = viewModel.cellViewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            // Le damos color a la celda
            let categoryColor = "#" + cellViewModel.category.color
            let colorfinal = viewModel.getColor(color: categoryColor)
            cell.backgroundColor = colorfinal
            return cell
        }
        fatalError()
    }
}

extension CategoriesViewController: UITableViewDelegate {
    // Pulsar un celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension CategoriesViewController: CategoriesViewProtocol {
    func categoriesFectched() {
        onCategoriesFetched()
    }
    func errorFetchingCategories() {
        onCategoriesFetchError()
    }
}

