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
        static let baseURL = ""
    }

    static func handleAPIError(from response: DataResponse<Any>) -> APIError {
        guard let data = response.data else {
            return APIError(message: response.error?.localizedDescription ?? "Unexpected Error")
        }

        do {
            return try JSONDecoder().decode(APIError.self, from: data)
        } catch {
            return APIError(message: response.error?.localizedDescription ?? "Unexpected Error")
        }
    }
}

protocol Input {
    var toDict: [String: Any] { get }
}

typealias ReturnOutput<T> = (T?, APIError?) -> Void
typealias ReturnBool = (Bool, APIError?) -> Void

protocol Output: Codable { }
