//
//  TaskInput.swift
//  ToDo
//
//  Created by Giovane Possebon on 23/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct TaskInput {
    let name: String?
    let done: Bool?

    init(name: String? = "", done: Bool? = nil) {
        self.name = name
        self.done = done
    }
}

extension TaskInput: Input {

    var toDict: [String : Any] {
        var params: [String: Any] = [:]

        if name != "" {
            params["name"] = name
        }

        if done != nil {
            params["done"] = done
        }

        return params
    }

}
