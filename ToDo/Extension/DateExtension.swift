//
//  DateExtension.swift
//  ToDo
//
//  Created by Giovane Possebon on 24/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation

extension Date {

    static func dateFrom(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.date(from: string) ?? Date()
    }

}
