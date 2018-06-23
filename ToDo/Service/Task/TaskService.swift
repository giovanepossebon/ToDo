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
}

struct TaskService: TaskServiceContract {

    func fetchTasks(todoId: Int, callback: @escaping (ReturnOutput<[TaskOutput]>)) {
        let url = UrlBuilder(path: [.todos, .custom("\(todoId)"), .items])
        Network.requestList(url, completion: callback)
    }

}
