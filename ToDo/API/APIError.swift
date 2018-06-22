//
//  APIError.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct APIError: Codable, Error {
    let message: String
}
