//
//  Auth.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation
import KeychainSwift

struct UserSessionKeys {
    static let authToken = "authToken"
}

class UserSession {
    static var shared = UserSession()

    var authToken: String {
        set {
            KeychainSwift().set(newValue, forKey: "")
        } get {
            return KeychainSwift().get("") ?? ""
        }
    }
}
