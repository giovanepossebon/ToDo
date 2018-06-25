//
//  TodoViewRouter.swift
//  ToDo
//
//  Created by Giovane Possebon on 23/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol TodoViewRouter {
    func toTodoList(id: Int, title: String)
    func toTodoEdit(id: Int, title: String)
}

class TodoViewRouterImplementation: TodoViewRouter {
    private let controller: TodoViewController

    init(controller: TodoViewController) {
        self.controller = controller
    }

    func toTodoList(id: Int, title: String) {
        let controller = TasksViewController()
        let viewModel = TasksPresenter.ViewModel(title: title, todoId: id)
        let presenter = TasksPresenter(view: controller, service: TaskService(), viewModel: viewModel, router: TasksViewRouterImplementation(controller: controller))
        controller.presenter = presenter

        self.controller.navigationController?.pushViewController(controller, animated: true)
    }

    func toTodoEdit(id: Int, title: String) {
        guard let todoPresenter = self.controller.presenter else { return }

        let controller = EditPopupViewController()
        let viewModel = EditPopupPresenter.ViewModel(id: id, value: title)
        let presenter = EditPopupPresenter(delegate: todoPresenter, view: controller, viewModel: viewModel)
        controller.presenter = presenter
        controller.modalPresentationStyle = .overCurrentContext

        self.controller.present(controller, animated: true, completion: nil)
    }
}
