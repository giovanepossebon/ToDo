//
//  TodoCell.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var cellContentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cellContentView.setupDropShadow()
        resetUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }

    func setup(title: String) {
        labelTitle.text = title
    }

    private func resetUI() {
        labelTitle.text = ""
    }
}
