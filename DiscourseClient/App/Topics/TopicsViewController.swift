//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class TopicsViewController: UIViewController {

    let viewModel: TopicsViewModel
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    init(viewModel: TopicsViewModel) {
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
    
    private func onTopicsFetched() {
        hideLoader()
        tableView.reloadData()
    }
    
    private func onTopicsFetchError() {
        hideLoader()
        showAlert(title: "Error al recibir los topics", message: "")
    }
    
    @objc private func onTapAddButton() {
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

extension TopicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell, let cellViewModel = viewModel.cellViewModel(at: indexPath) {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    // Pulsar un celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension TopicsViewController: TopicsViewProtocol {
    func topicsFectched() {
        onTopicsFetched()
    }
    func errorFetchingTopics() {
        onTopicsFetchError()
    }
}
