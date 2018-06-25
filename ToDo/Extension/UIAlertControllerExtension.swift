//
//  UIAlertActionExtension.swift
//  ToDo
//
//  Created by Giovane Possebon on 24/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

extension UIAlertController {

    static func errorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Hey", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }

}
