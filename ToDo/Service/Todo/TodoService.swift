//
//  TodoService.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol TodoServiceContract {
    func fetchTodos(callback: @escaping (ReturnOutput<[TodoOutput]>))
    func createTodo(input: TodoInput, callback: @escaping (ReturnOutput<TodoOutput>))
    func deleteTodo(id: Int, callback: @escaping (ReturnBool))
    func editTodo(id: Int, input: TodoInput, callback: @escaping (ReturnBool))
}

struct TodoService: TodoServiceContract {

    func fetchTodos(callback: @escaping (ReturnOutput<[TodoOutput]>)) {
        let url = UrlBuilder(path: [.todos])
        Network.requestList(url, completion: callback)
    }

    func createTodo(input: TodoInput, callback: @escaping (ReturnOutput<TodoOutput>)) {
        let url = UrlBuilder(path: [.todos])
        Network.requestObject(url, method: .post, parameters: input, completion: callback)
    }

    func deleteTodo(id: Int, callback: @escaping (ReturnBool)) {
        let url = UrlBuilder(path: [.todos, .custom("\(id)")])
        Network.requestBool(url, method: .delete, completion: callback)
    }

    func editTodo(id: Int, input: TodoInput, callback: @escaping (ReturnBool)) {
        let url = UrlBuilder(path: [.todos, .custom("\(id)")])
        Network.requestBool(url, method: .patch, parameters: input, completion: callback)
    }
}
