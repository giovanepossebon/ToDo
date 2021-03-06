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

        if whiteNavigationBar {
            navigationBar.isTranslucent = false
            navigationBar.backgroundColor = .white
        } else {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.isTranslucent = true
            navigationBar.shadowImage = UIImage()
        }

        navigationBar.tintColor = whiteNavigationBar ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationBar.titleTextAttributes  = [NSAttributedStringKey.foregroundColor: whiteNavigationBar ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    }

}
