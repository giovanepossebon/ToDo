//
//  TodoService.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol TodoServiceContract {
    func fetchTodos(callback: @escaping (Response<[TodoOutput]>) -> ())
}

struct TodoService: TodoServiceContract {

    func fetchTodos(callback: @escaping (Response<[TodoOutput]>) -> ()) {
        let url = UrlBuilder(path: [.todos])

        Network.request(url, method: .get) { response, error in
            switch response.result {
            case .success:
                guard error == nil else {
                    callback(Response<[TodoOutput]>(data: [], result: .error(message: error?.message ?? "")))
                    return
                }

                guard let data = response.data else {
                    callback(Response<[TodoOutput]>(data: [], result: .error(message: "Unexpected error")))
                    return
                }

                do {
                    let todos = try JSONDecoder().decode([TodoOutput].self, from: data)
                    callback(Response<[TodoOutput]>(data: todos, result: .success))
                } catch {
                    callback(Response<[TodoOutput]>(data: nil, result: .error(message: "Problem with serialization")))
                }

            case .failure(let error):
                callback(Response<[TodoOutput]>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }

}
