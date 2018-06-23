//
//  AppDelegate.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        makeInitialViewController()

        return true
    }

    private func makeInitialViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)

        let controller = LoginViewController()
        let presenter = LoginPresenter(view: controller, router: LoginViewRouterImplementation(loginViewController: controller), service: LoginService())
        controller.presenter = presenter

        window?.rootViewController = controller

        window?.makeKeyAndVisible()
    }

}

