//
//  SignUpEmailStepViewRouter.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

protocol SignUpEmailStepViewRouter {
    func presentPassword(name: String, email: String)
}

class SignUpEmailStepViewRouterImplementation: SignUpEmailStepViewRouter {
    fileprivate weak var controller: SignUpEmailStepViewController?

    init(controller: SignUpEmailStepViewController) {
        self.controller = controller
    }

    func presentPassword(name: String, email: String) {
        let controller = SignUpPasswordViewController()
        let viewModel = SignUpPasswordPresenter.ViewModel(name: name, email: email)
        let presenter = SignUpPasswordPresenter(view: controller, router: SignUpPasswordViewRouterImplementation(controller: controller), service: SignupService(), viewModel: viewModel)
        controller.presenter = presenter

        self.controller?.navigationController?.pushViewController(controller, animated: true)
    }

}
