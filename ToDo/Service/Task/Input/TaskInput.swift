//
//  TaskInput.swift
//  ToDo
//
//  Created by Giovane Possebon on 23/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct TaskInput {
    let name: String
    let done: Bool
}

extension TaskInput: Input {

    var toDict: [String : Any] {
        return ["name": name,
                "done": done]
    }

}

struct TaskEditInput {
    let name: String
}

extension TaskEditInput: Input {

    var toDict: [String : Any] {
        return ["name": name]
    }

}
