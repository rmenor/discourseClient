//
//  CategoryCell.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class CategoryCell: UITableViewCell {
    var viewModel: CategoryCellViewModel? {
        didSet{
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.category.name
        }
    }
}
