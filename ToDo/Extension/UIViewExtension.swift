//
//  UIViewExtension.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import UIKit

extension UIView {

    func setupDropShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 6)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2.0
        clipsToBounds = false
        layer.masksToBounds = false
    }

}
