//
//  LoginService.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol LoginServiceContract {
    func login(input: LoginInput, callback: @escaping ReturnBool)
}

struct LoginService: LoginServiceContract {

    func login(input: LoginInput, callback: @escaping ReturnBool) {
        let url = UrlBuilder(path: [.auth, .login])
        Network.requestBool(url, method: .post, parameters: input, completion: callback)
    }
}
