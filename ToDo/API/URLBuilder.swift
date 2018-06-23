//
//  URLBuilder.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation
import Alamofire

struct UrlBuilder {
    let paths: [Path]
    let queries: [String]?

    init(path: [Path], query: [String]? = nil) {
        self.paths = path
        self.queries = query
    }
}

extension UrlBuilder: URLConvertible {
    func asURL() throws -> URL {
        let baseString = API.URLs.baseURL

        let pathString = paths.reduce("") { current, path in
            return current + "/" + path.getPath()
        }

        let queryString = queries?.enumerated().reduce("") { current, element in
            let symbol = element.offset == 0 ? "?" : "&"
            return current! + symbol + element.element
            } ?? ""

        let urlString = baseString + pathString + queryString

        guard let url = URL(string: urlString) else {
            throw AFError.invalidURL(url: urlString)
        }

        return url
    }
}

enum Path {
    case auth
    case custom(String)
    case login
    case signup
    case todos

    func getPath() -> String {
        switch self {
        case let .custom(value):
            return "\(value)"
        default:
            return "\(self)"
        }

    }

}
