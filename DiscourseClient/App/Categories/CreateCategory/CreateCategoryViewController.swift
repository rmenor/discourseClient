//
//  CreateCategoryViewController.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CreateCategoryViewController: UIViewController {
    @IBOutlet weak var textFieldName: UITextField! {
        didSet {
            textFieldName.placeholder = "Añade aquí tu categoría"
        }
    }
    
    @IBOutlet weak var textFieldColor: UITextField! {
        didSet {
            textFieldColor.placeholder = "Añade aquí el color"
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
    
    let viewModel: CreateCategoryViewModel
    
    init(viewModel: CreateCategoryViewModel) {
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
        viewModel.onCreateCategorySuccess = {
            self.hideLoader()
            self.showAlert(title: "Añadido", message: "")
        }
        
        viewModel.onCreateCategoryFail = { [weak self] error in
            self?.hideLoader()
            self?.showAlert(title: error, message: "")
        }
    }
    
    @IBAction func onTapSubMitButton(_ sender: UIButton) {
        guard let name = textFieldName.text, !name.isEmpty else {
            showAlert(title: "Esta vacio", message: "")
            return
        }
        guard let color = textFieldColor.text, !color.isEmpty else {
            showAlert(title: "Esta vacio", message: "")
            return
        }
        showLoader()
        viewModel.onTapSubmitButton(name: name, color: color)
    }
}

extension CreateCategoryViewController: CreateCategoryViewProtocol {
    
}
