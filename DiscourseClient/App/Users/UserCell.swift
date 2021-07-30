//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class UserCell: UITableViewCell {
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            viewModel.view = self
            textLabel?.text = viewModel.textLabel
            imageView?.image = viewModel.userImage
        }
    }
}

extension UserCell: UserCellViewProtocol {
    func userImageFetched() {
        imageView?.image = viewModel?.userImage
        setNeedsLayout()
    }
}
