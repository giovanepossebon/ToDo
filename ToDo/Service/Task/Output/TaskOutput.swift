//
//  TaskOutput.swift
//  ToDo
//
//  Created by Giovane Possebon on 23/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct TaskOutput: Codable, Output {
    let id: Int
    let name: String
    let done: Bool
    let todoId: Int
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case done
        case todoId = "todo_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
