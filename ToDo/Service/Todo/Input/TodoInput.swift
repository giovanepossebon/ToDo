//
//  TodoInput.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct TodoInput {
    let title: String
}

extension TodoInput: Input {

    var toDict: [String : Any] {
        return ["title": title]
    }

}
