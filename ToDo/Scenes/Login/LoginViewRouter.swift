//
//  LoginRouter.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

protocol LoginViewRouter {
    func presentSignUp()
    func login()
}

class LoginViewRouterImplementation: LoginViewRouter {
    fileprivate weak var loginViewController: LoginViewController?

    init(loginViewController: LoginViewController) {
        self.loginViewController = loginViewController
    }

    func presentSignUp() {
        let controller = SignUpNameStepViewController()
        let navigation = BaseNavigationController(rootViewController: controller)
        loginViewController?.present(navigation, animated: true, completion: nil)
    }

    func login() {

    }
}
