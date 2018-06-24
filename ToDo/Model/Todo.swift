//
//  Todo.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct Todo {
    let id: Int
    let title: String
    let created: Date
    let updated: Date
}

extension Todo {
    init(output: TodoOutput) {
        self.id = output.id
        self.title = output.title
        self.created = Date.dateFrom(string: output.createdAt)
        self.updated = Date.dateFrom(string: output.updatedAt)
    }
}
