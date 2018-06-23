//
//  SignupService.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol SignupServiceContract {
    func signUp(input: SignupInput, callback: @escaping (ReturnOutput<SignupOutput>))
}

struct SignupService: SignupServiceContract {

    func signUp(input: SignupInput, callback: @escaping (ReturnOutput<SignupOutput>)) {
        let url = UrlBuilder(path: [.signup])
        Network.requestObject(url, method: .post, parameters: input, completion: callback)
    }

}
