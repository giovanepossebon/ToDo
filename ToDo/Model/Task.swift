//
//  Task.swift
//  ToDo
//
//  Created by Giovane Possebon on 23/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct Task {
    let id: Int
    let name: String
    var done: Bool
    let todoId: Int
    let created: Date
}

extension Task {
    init(output: TaskOutput) {
        id = output.id
        name = output.name
        done = output.done
        todoId = output.todoId
        created = Date.dateFrom(string: output.createdAt)
    }
}
