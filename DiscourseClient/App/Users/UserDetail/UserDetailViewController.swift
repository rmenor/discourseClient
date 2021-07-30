//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    lazy var labelUserIDValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userIDStackView: UIStackView = {
        let labelUserId = UILabel()
        labelUserId.translatesAutoresizingMaskIntoConstraints = false
        labelUserId.text = "Id: "
        
        let stack = UIStackView(arrangedSubviews: [labelUserId, labelUserIDValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        
        return stack
    }()
    
    lazy var labelNameValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameStackView: UIStackView = {
        let labelName = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.text = "Nombre: "
        
        let stack = UIStackView(arrangedSubviews: [labelName, labelNameValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        
        return stack
    }()
    
    lazy var updateNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Actualizar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(updateNameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var textFieldUserName: UITextField = {
        let textFieldUserName = UITextField()
        textFieldUserName.borderStyle = .line
        textFieldUserName.translatesAutoresizingMaskIntoConstraints = false
        return textFieldUserName
    }()
    
    lazy var newUserNameStackView: UIStackView = {
        let labelNewName = UILabel()
        labelNewName.translatesAutoresizingMaskIntoConstraints = false
        labelNewName.text = "Nuevo nombre: "
        
        let stack = UIStackView(arrangedSubviews: [labelNewName, textFieldUserName])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        return stack
    }()
    
    let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIDStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128)
        ])
        
        view.addSubview(nameStackView)
        NSLayoutConstraint.activate([
            nameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            // Enganchado a la parte de abajo del stack anterior
            nameStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 32)
        ])
        
        view.addSubview(newUserNameStackView)
        NSLayoutConstraint.activate([
            newUserNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            // Enganchado a la parte de abajo del stack anterior
            newUserNameStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 32),
            textFieldUserName.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        view.addSubview(updateNameButton)
        NSLayoutConstraint.activate([
            updateNameButton.topAnchor.constraint(equalTo: newUserNameStackView.bottomAnchor, constant: 32),
            // Enganchado a la parte de abajo del stack anterior
            updateNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateNameButton.heightAnchor.constraint(equalToConstant: 40),
            updateNameButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showLoader()
    }
    
    @objc func updateNameButtonTapped() {
        guard let name = textFieldUserName.text, !name.isEmpty else { showAlert(title: "ESta vacio", message: "")
            return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
            self.showLoader()
        }
        viewModel.updateNameButtonTapped(name: name)
        textFieldUserName.text = ""
    }

    private func updateData(userDetail: UserDetailViewStruct) {
        labelUserIDValue.text =  userDetail.userId
        labelNameValue.text = userDetail.nameLabel
        
        // Permite editar o no
        updateNameButton.isHidden = !userDetail.canEditName
        newUserNameStackView.isHidden = !userDetail.canEditName
    }
    
    private func showErrorFectchingUser() {
        showAlert(title: "Error fetching user", message: "")
    }
    
    private func showSuccessUpdatingUserName() {
        hideLoader()
        showAlert(title: "El nombre de usuario ha cambiado", message: "")
    }
    
    private func showErrorUpdatingUserName() {
        hideLoader()
        showAlert(title: "Error al actualizar el nombre", message: "")
    }
}

extension UserDetailViewController: UserDetailViewProtocol {
    func onUpdateUserNameSuccess(userDetail: UserDetailViewStruct) {
        updateData(userDetail: userDetail)
        showSuccessUpdatingUserName()
    }
    
    func onUpdateUserNameFail() {
        showErrorUpdatingUserName()
    }
    
    func onGetUserSuccess(userDetail: UserDetailViewStruct) {
        hideLoader()
        updateData(userDetail: userDetail)
    }
    
    func onGetUserFail() {
        hideLoader()
        showErrorFectchingUser()
    }
}
