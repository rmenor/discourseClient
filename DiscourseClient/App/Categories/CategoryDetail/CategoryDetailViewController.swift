//
//  CategoryDetailViewController.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    
    let viewModel: CategoryDetailViewModel
    
    var labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var categoryNameStackView: UIStackView = {
        let labelNameTitle = UILabel()
        labelNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelNameTitle.text = "Nombre: "

        let categoryNameStackView = UIStackView(arrangedSubviews: [labelNameTitle, labelName])
        categoryNameStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryNameStackView.axis = .horizontal
        return categoryNameStackView
    }()
    
    var labelColor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var categoryColorStackView: UIStackView = {
        let labelColorTitle = UILabel()
        labelColorTitle.translatesAutoresizingMaskIntoConstraints = false
        labelColorTitle.text = "Color: "

        let categoryColorStackView = UIStackView(arrangedSubviews: [labelColorTitle, labelColor])
        categoryColorStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryColorStackView.axis = .horizontal
        return categoryColorStackView
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(categoryNameStackView)
        NSLayoutConstraint.activate([
            categoryNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            categoryNameStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
        ])
        
        view.addSubview(categoryColorStackView)
        NSLayoutConstraint.activate([
            categoryColorStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            categoryColorStackView.topAnchor.constraint(equalTo: categoryNameStackView.bottomAnchor, constant: 32)
        ])
    }
    
    init(viewModel: CategoryDetailViewModel) {
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
        viewModel.onGetCategorySuccess = { [weak self] categoryDetailViewStruct in
            self?.hideLoader()
            self?.updateUI(categoryDetailViewStruct: categoryDetailViewStruct)
        }
        viewModel.onGetCategoryFail = { [weak self] in
            self?.hideLoader()
            self?.showAlert(title: "Error recibiendo categoría", message: "")
        }
    }
    
    private func updateUI(categoryDetailViewStruct: CategoryDetailViewStruct) {
        labelName.text = categoryDetailViewStruct.categoryName
        labelColor.text = "#" + categoryDetailViewStruct.categoryColor!
        labelColor.backgroundColor = viewModel.getColor(color: labelColor.text!)
    }
}
