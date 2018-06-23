//
//  TodoCell.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

protocol TodoCellDelegate {
    func didTouchEdit(cell: TodoCell)
    func didTouchDelete(cell: TodoCell)
}

class TodoCell: UITableViewCell {
    
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var cellContentView: UIView!

    private var delegate: TodoCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        cellContentView.setupDropShadow()
        resetUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }

    func setup(title: String, delegate: TodoCellDelegate) {
        labelTitle.text = title
        self.delegate = delegate
    }

    private func resetUI() {
        labelTitle.text = ""
    }

    @IBAction func didTouchEdit(_ sender: Any) {
        delegate?.didTouchEdit(cell: self)
    }

    @IBAction func didTouchDelete(_ sender: Any) {
        delegate?.didTouchDelete(cell: self)
    }
}
