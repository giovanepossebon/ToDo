//
//  BaseNavigationController.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    // MARK: Properties

    var whiteNavigationBar = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    // MARK: Lifecycle

    convenience init(rootViewController: UIViewController, whiteNavigationBar: Bool) {
        self.init(rootViewController: rootViewController)
        self.whiteNavigationBar = whiteNavigationBar
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationBar.setBackgroundImage(UIImage(), for: .default)

        if whiteNavigationBar {
            navigationBar.isTranslucent = false
            navigationBar.backgroundColor = .white
        } else {
            navigationBar.isTranslucent = true
            navigationBar.shadowImage = UIImage()
        }

        navigationBar.tintColor = whiteNavigationBar ? #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationBar.titleTextAttributes  = [NSAttributedStringKey.foregroundColor: whiteNavigationBar ? #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }

}
