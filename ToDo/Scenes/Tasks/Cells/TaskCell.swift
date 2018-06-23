//
//  TaskCell.swift
//  ToDo
//
//  Created by Giovane Possebon on 23/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

protocol TaskCellDelegate {
    func didTouchDone(cell: UITableViewCell)
}

class TaskCell: UITableViewCell {

    @IBOutlet weak var labelTask: UILabel!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var cellContentView: UIView!

    private var delegate: TaskCellDelegate?

    func setup(task: Task, delegate: TaskCellDelegate) {
        labelTask.text = task.name
        buttonDone.isSelected = task.done
        self.delegate = delegate
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cellContentView.setupDropShadow()

        resetUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        resetUI()
    }

    private func resetUI() {
        labelTask.text = ""
    }

    @IBAction func didTouchDone(_ sender: Any) {
        delegate?.didTouchDone(cell: self)
    }
    
}
