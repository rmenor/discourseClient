//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class TopicDetailViewController: UIViewController {
    
    let viewModel: TopicDetailViewModel
    
    var labelTopicID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle = UILabel()
        labelTopicIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = "Topic ID: "
        
        let topicIDStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .horizontal
        return topicIDStackView
    }()
    
    var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topicNameStackView: UIStackView = {
        let labelNameTitle = UILabel()
        labelNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelNameTitle.text = "Topic: "
        
        let topicNameStackView = UIStackView(arrangedSubviews: [labelNameTitle, labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .horizontal
        return topicNameStackView
    }()
    
    let postsNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var postNumberStackView: UIStackView = {
        let postNumberTitleLabel = UILabel()
        postNumberTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        postNumberTitleLabel.text = "Nombre: "
        
        let postNumberStackView = UIStackView(arrangedSubviews: [postNumberTitleLabel, postsNumberLabel])
        postNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        postNumberStackView.axis = .horizontal
        return postNumberStackView
    }()
    
    let deleteTopicButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Eliminar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(onTapDeleteButton), for: .touchUpInside)
        button.titleEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8) // Padding
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return button
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicIDStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128)
        ])
        
        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            // Enganchado a la parte de abajo del stack anterior
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 32)
        ])
        
//        view.addSubview(postNumberStackView)
//        NSLayoutConstraint.activate([
//            postNumberStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
//            // Enganchado a la parte de abajo del stack anterior
//            postNumberStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 32),
//            postNumberStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16)
//        ])
        
        view.addSubview(deleteTopicButton)
        NSLayoutConstraint.activate([
            deleteTopicButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteTopicButton.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 32),
        ])
        
        deleteTopicButton.isHidden = true
    }
    
    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        bindViewModel()
    }
    
    // Recibe por aquí del viewmodel
    func bindViewModel(){
        viewModel.onGetTopicSuccess = { [weak self] topicDetailViewStruct in
            self?.hideLoader()
            self?.updateUI(topicDetailViewStruct: topicDetailViewStruct)
        }
        viewModel.onGetTopicFail = { [weak self] in
            self?.hideLoader()
            self?.showAlert(title: "Error recibiendo topic", message: "")
        }
        viewModel.onDeleteSuccess = { [weak self] in
            self?.hideLoader()
            self?.showAlert(title: "Topic eliminado", message: "")
        }
        viewModel.onDeleteFail = {  [weak self] error in
            self?.showAlert(title: error, message: "")
        }
    }
    
    private func updateUI(topicDetailViewStruct: TopicDetailViewStruct) {
        labelTopicID.text = topicDetailViewStruct.topicId
        labelTopicTitle.text = topicDetailViewStruct.topicName
        postsNumberLabel.text = topicDetailViewStruct.postNumber
        deleteTopicButton.isHidden = !topicDetailViewStruct.topicCanBeDeleted
    }
    
    @objc private func onTapDeleteButton() {
        showLoader()
        viewModel.onTabDeleteButton()
    }
}
