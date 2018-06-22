//
//  LoginRequest.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct LoginInput {
    let email: String
    let password: String
}

extension LoginInput: Input {

    var toDict: [String : Any] {
        return ["email": email,
                "password": password]
    }

}
