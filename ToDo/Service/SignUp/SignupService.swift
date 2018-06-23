//
//  SignupService.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

protocol SignupServiceContract {
    func signUp(input: SignupInput, callback: @escaping (Response<SignupOutput>) -> ())
}

struct SignupService: SignupServiceContract {

    func signUp(input: SignupInput, callback: @escaping (Response<SignupOutput>) -> ()) {
        let url = UrlBuilder(path: [.signup])

        Network.request(url, method: .post, parameters: input) { response, error in
            switch response.result {
            case .success:
                guard error == nil else {
                    callback(Response<SignupOutput>(data: nil, result: .error(message: error?.message ?? "")))
                    return
                }

                guard let data = response.data else {
                    callback(Response<SignupOutput>(data: nil, result: .error(message: "Unexpected Error")))
                    return
                }

                do {
                    let signup = try JSONDecoder().decode(SignupOutput.self, from: data)
                    callback(Response<SignupOutput>(data: signup, result: .success))
                } catch {
                    callback(Response<SignupOutput>(data: nil, result: .error(message: "Problem with serialization")))
                }
            case .failure(let error):
                callback(Response<SignupOutput>(data: nil, result: .error(message: error.localizedDescription)))
            }
        }
    }

}
