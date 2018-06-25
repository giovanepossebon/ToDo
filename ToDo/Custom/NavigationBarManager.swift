//
//  NavigationBarManager.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

enum NavigationBarTintStyle {
    case transparent, white
}

protocol NavigationBarManager { }

extension NavigationBarManager where Self: UIViewController {

    func setupNavigationBar(title: String) {
        navigationItem.titleView = nil
        navigationItem.title = title
    }

    func setupNavigationBarWithoutTitle() {
        navigationItem.titleView = nil
    }

    func hideBackButton() {
        navigationItem.hidesBackButton = true
    }

}
