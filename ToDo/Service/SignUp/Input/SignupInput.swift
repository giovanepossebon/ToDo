//
//  SignupInput.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct SignupInput {
    let name: String
    let email: String
    let password: String
    let repassword: String
}

extension SignupInput: Input {

    var toDict: [String : Any] {
        return ["name": name,
                "email": email,
                "password": password,
                "password_confirmation": repassword]
    }

}
