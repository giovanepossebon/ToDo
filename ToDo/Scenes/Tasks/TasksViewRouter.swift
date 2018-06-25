//
//  TasksViewRouter.swift
//  ToDo
//
//  Created by Giovane Possebon on 24/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol TasksViewRouter {
    func routeToEdit(task: Task)
}

class TasksViewRouterImplementation: TasksViewRouter {
    private let controller: TasksViewController

    init(controller: TasksViewController) {
        self.controller = controller
    }

    func routeToEdit(task: Task) {
        guard let taskPresenter = self.controller.presenter else { return }

        let controller = EditPopupViewController()
        let viewModel = EditPopupPresenter.ViewModel(id: task.id, value: task.name)
        let presenter = EditPopupPresenter(delegate: taskPresenter, view: controller, viewModel: viewModel)
        controller.presenter = presenter
        controller.modalPresentationStyle = .overCurrentContext

        self.controller.present(controller, animated: true, completion: nil)
    }

}
