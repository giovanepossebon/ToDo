//
//  ToDoAPI.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct API {

    struct URLs {
        static let baseURL = "https://todos.flexhire.com"
    }

}

struct Response<T> {
    var data: T?
    let result: Result
}

enum Result {
    case success
    case error(message: String)
}

protocol Input {
    var toDict: [String: Any] { get }
}
