//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

class TopicCell: UITableViewCell {
    var viewModel: TopicCellViewModel? {
        didSet{
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.topic.title
        }
    }
}
