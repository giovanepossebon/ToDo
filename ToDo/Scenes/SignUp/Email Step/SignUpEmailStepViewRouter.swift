//
//  SignUpEmailStepViewRouter.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

protocol SignUpEmailStepViewRouter {
    func presentPassword(email: String)
}

class SignUpEmailStepViewRouterImplementation: SignUpEmailStepViewRouter {
    fileprivate weak var controller: SignUpEmailStepViewController?

    init(controller: SignUpEmailStepViewController) {
        self.controller = controller
    }

    func presentPassword(email: String) {

    }

}
