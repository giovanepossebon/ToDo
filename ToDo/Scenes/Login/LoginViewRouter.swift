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
    private let loginViewController: LoginViewController

    init(loginViewController: LoginViewController) {
        self.loginViewController = loginViewController
    }

    func presentSignUp() {
        let controller = SignUpNameStepViewController()
        let presenter = SignUpNameStepPresenter(view: controller, router: SignUpNameStepViewRouterImplementation(controller: controller))
        controller.presenter = presenter

        let navigation = BaseNavigationController(rootViewController: controller)
        loginViewController.present(navigation, animated: true, completion: nil)
    }

    func login() {
        let controller = TodoViewController()
        let presenter = TodoPresenter(view: controller, service: TodoService(), router: TodoViewRouterImplementation(controller: controller))
        controller.presenter = presenter

        let navigation = BaseNavigationController(rootViewController: controller)
        navigation.whiteNavigationBar = true
        loginViewController.present(navigation, animated: true, completion: nil)
    }
}
