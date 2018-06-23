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
    let done: Bool
}

extension Task {
    init(output: TaskOutput) {
        id = output.id
        name = output.name
        done = output.done
    }
}
