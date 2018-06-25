//
//  SignUpPasswordViewRouter.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

protocol SignUpPasswordViewRouter {
    func toSuccess(message: String)
}

class SignUpPasswordViewRouterImplementation: SignUpPasswordViewRouter {

    private let controller: SignUpPasswordViewController

    init(controller: SignUpPasswordViewController) {
        self.controller = controller
    }

    func toSuccess(message: String) {
        let controller = SuccessViewController()
        let viewModel = SuccessPresenter.ViewModel(message: message)
        let presenter = SuccessPresenter(view: controller, viewModel: viewModel, delegate: self)
        controller.presenter = presenter

        self.controller.present(controller, animated: true, completion: nil)
    }

}

extension SignUpPasswordViewRouterImplementation: SuccessDelegate {

    func successDidDismiss(viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: { [weak self] in
            self?.controller.dismiss(animated: true, completion: nil)
        })
    }

}
