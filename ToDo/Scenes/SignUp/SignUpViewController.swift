//
//  SignUpViewController.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: Initialization

    init() {
        super.init(nibName: "SignUpViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sign up"
    }
}
