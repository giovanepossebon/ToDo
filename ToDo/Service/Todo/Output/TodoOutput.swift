//
//  TodoOutput.swift
//  ToDo
//
//  Created by Giovane Possebon on 22/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

struct TodoOutput: Codable, Output {
    let id: Int
    let title: String
    let createdBy: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

