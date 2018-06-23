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
}

struct TodoService: TodoServiceContract {

    func fetchTodos(callback: @escaping (ReturnOutput<[TodoOutput]>)) {
        let url = UrlBuilder(path: [.todos])
        Network.requestList(url, completion: callback)
    }

}
