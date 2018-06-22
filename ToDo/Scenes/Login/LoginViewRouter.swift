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
}

class LoginViewRouterImplementation: LoginViewRouter {
    fileprivate weak var loginViewController: LoginViewController?

    init(loginViewController: LoginViewController) {
        self.loginViewController = loginViewController
    }

    func presentSignUp() {
        let controller = SignUpViewController()
        let navigation = UINavigationController(rootViewController: controller)
        loginViewController?.present(navigation, animated: true, completion: nil)
    }
}
