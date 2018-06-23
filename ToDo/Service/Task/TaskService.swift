//
//  TaskService.swift
//  ToDo
//
//  Created by Giovane Possebon on 23/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol TaskServiceContract {
    func fetchTasks(todoId: Int, callback: @escaping (ReturnOutput<[TaskOutput]>))
    func createTask(todoId: Int, input: TaskInput, callback: @escaping (ReturnBool))
    func deleteTask(todoId: Int, itemId: Int, callback: @escaping (ReturnBool))
}

struct TaskService: TaskServiceContract {

    func fetchTasks(todoId: Int, callback: @escaping (ReturnOutput<[TaskOutput]>)) {
        let url = UrlBuilder(path: [.todos, .custom("\(todoId)"), .items])
        Network.requestList(url, completion: callback)
    }

    func createTask(todoId: Int, input: TaskInput, callback: @escaping (ReturnBool)) {
        let url = UrlBuilder(path: [.todos, .custom("\(todoId)"), .items])
        Network.requestBool(url, method: .post, parameters: input, completion: callback)
    }

    func deleteTask(todoId: Int, itemId: Int, callback: @escaping (ReturnBool)) {
        let url = UrlBuilder(path: [.todos, .custom("\(todoId)"), .items, .custom("\(itemId)")])
        Network.requestBool(url, method: .delete, completion: callback)
    }

}
