//
//  CreateTopicViewController.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CreateTopicViewController: UIViewController {
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.placeholder = "Añade aquí tu topic"
        }
    }
    @IBOutlet weak var submitButton: UIButton! {
        didSet {
            submitButton.setTitle("Añadir", for: .normal)
            submitButton.backgroundColor = .green
            submitButton.setTitleColor(.black, for: .normal)
            submitButton.layer.cornerRadius = 10
        }
    }
    
    let viewModel: CreateTopicViewModel
    
    init(viewModel: CreateTopicViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // Para manejar los clousures
    func bindViewModel() {
        viewModel.onCreateTopicSuccess = {
            self.hideLoader()
            self.showAlert(title: "Añadido", message: "")
        }
        
        viewModel.onCreateTopicFail = { [weak self] error in
            self?.hideLoader()
            self?.showAlert(title: error, message: "")
        }
    }
    
    @IBAction func onTapSubMitButton(_ sender: UIButton) {
        guard let title = textField.text, !title.isEmpty else {
            showAlert(title: "Esta vacio", message: "")
            return
        }
        showLoader()
        viewModel.onTapSubmitButton(title: title)
    }
}

extension CreateTopicViewController: CreateTopicViewProtocol {
    
}
