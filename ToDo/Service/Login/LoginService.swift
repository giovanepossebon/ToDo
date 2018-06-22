//
//  LoginService.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct LoginService {

    static func login(input: LoginInput, callback: @escaping (Response<LoginOutput>) -> ()) {
        let url = UrlBuilder(path: [.auth, .login])

        Network.request(url, method: .post, parameters: input) { response, error  in
            switch response.result {
            case .success:
                guard error == nil else {
                    callback(Response<LoginOutput>(data: nil, result: .error(message: error?.message ?? "")))
                    return
                }

                guard let data = response.data else {
                    callback(Response<LoginOutput>(data: nil, result: .error(message: "Unexpected Error")))
                    return
                }

                do {
                    let login = try JSONDecoder().decode(LoginOutput.self, from: data)
                    callback(Response<LoginOutput>(data: login, result: .success))
                } catch {
                    callback(Response<LoginOutput>(data: nil, result: .error(message: "Problem with serialization")))
                }
            case .failure(let error):
                callback(Response<LoginOutput>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }
}
