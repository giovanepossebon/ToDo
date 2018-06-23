//
//  LoginService.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol LoginServiceContract {
    func login(input: LoginInput, callback: @escaping (ReturnOutput<LoginOutput>))
}

struct LoginService: LoginServiceContract {

    func login(input: LoginInput, callback: @escaping (ReturnOutput<LoginOutput>)) {
        let url = UrlBuilder(path: [.auth, .login])
        Network.requestObject(url, method: .post, parameters: input, completion: callback)
    }
}
