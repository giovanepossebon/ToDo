//
//  TodoViewRouter.swift
//  ToDo
//
//  Created by Giovane Possebon on 23/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol TodoViewRouter {
    func toTodoList(id: Int)
    func toTodoEdit(id: Int)
}

class TodoViewRouterImplementation: TodoViewRouter {
    fileprivate var controller: TodoViewController?

    init(controller: TodoViewController) {
        self.controller = controller
    }

    func toTodoList(id: Int) {
        let controller = TasksViewController()
        let viewModel = TasksPresenter.ViewModel(todoId: id)
        let presenter = TasksPresenter(view: controller, service: TaskService(), viewModel: viewModel)
        controller.presenter = presenter

        self.controller?.navigationController?.pushViewController(controller, animated: true)
    }

    func toTodoEdit(id: Int) {

    }
}
