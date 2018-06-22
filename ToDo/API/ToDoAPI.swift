//
//  ToDoAPI.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Alamofire
import Foundation

struct API {

    struct URLs {
        static let baseURL = "https://todos.flexhire.com"
    }

    static func handleAPIError(from response: DataResponse<Any>) -> APIError {
        guard let data = response.data else {
            return APIError(message: "")
        }

        do {
            return try JSONDecoder().decode(APIError.self, from: data)
        } catch {
            return APIError(message: "")
        }
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

