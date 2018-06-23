//
//  SignupOutput.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct SignupOutput: Codable {
    let message: String
    let authToken: String

    enum CodingKeys: String, CodingKey {
        case message
        case authToken = "auth_token"
    }
}
