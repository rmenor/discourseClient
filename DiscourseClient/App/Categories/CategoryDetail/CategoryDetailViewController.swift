//
//  CategoryDetailViewController.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    
    let viewModel: CategoryDetailViewModel
    
    var labelId: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var categoryIdStackView: UIStackView = {
        let labelIdTitle = UILabel()
        labelIdTitle.translatesAutoresizingMaskIntoConstraints = false
        labelIdTitle.text = "Categoría ID: "

        let categoryIdStackView = UIStackView(arrangedSubviews: [labelIdTitle, labelId])
        categoryIdStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryIdStackView.axis = .horizontal
        return categoryIdStackView
    }()
    
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
    
    lazy var viewColorStackView: UIStackView = {
        let viewColorStackView = UIStackView(arrangedSubviews: [])
        viewColorStackView.translatesAutoresizingMaskIntoConstraints = false
        viewColorStackView.axis = .horizontal
        return viewColorStackView
    }()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(categoryIdStackView)
        NSLayoutConstraint.activate([
            categoryIdStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            categoryIdStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
        ])
        
        view.addSubview(categoryNameStackView)
        NSLayoutConstraint.activate([
            categoryNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            categoryNameStackView.topAnchor.constraint(equalTo: categoryIdStackView.bottomAnchor, constant: 32)
        ])
        
        view.addSubview(categoryColorStackView)
        NSLayoutConstraint.activate([
            categoryColorStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            categoryColorStackView.topAnchor.constraint(equalTo: categoryNameStackView.bottomAnchor, constant: 32)
        ])
        
        view.addSubview(viewColorStackView)
        NSLayoutConstraint.activate([
            viewColorStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            viewColorStackView.topAnchor.constraint(equalTo: categoryColorStackView.bottomAnchor, constant: 32)
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
        labelId.text = categoryDetailViewStruct.categoryId
        labelName.text = categoryDetailViewStruct.categoryName
        labelColor.text = "#" + categoryDetailViewStruct.categoryColor!
        labelColor.backgroundColor = viewModel.getColor(color: labelColor.text!)
        viewColorStackView.backgroundColor = viewModel.getColor(color: labelColor.text!)
    }
}
