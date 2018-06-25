//
//  SignUpNameRouter.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

protocol SignUpNameStepViewRouter {
    func presentEmailStep(name: String)
    func dismiss()
}

class SignUpNameStepViewRouterImplementation: SignUpNameStepViewRouter {
    fileprivate weak var controller: SignUpNameStepViewController?

    init(controller: SignUpNameStepViewController) {
        self.controller = controller
    }

    func presentEmailStep(name: String) {
        let model = SignUpEmailStepPresenter.ViewModel(name: name)
        let view = SignUpEmailStepViewController()
        let presenter = SignUpEmailStepPresenter(view: view, router: SignUpEmailStepViewRouterImplementation(controller: view), viewModel: model)
        view.presenter = presenter

        controller?.navigationController?.pushViewController(view, animated: true)
    }

    func dismiss() {
        controller?.dismiss(animated: true, completion: nil)
    }
}
