//
//  Network.swift
//  ToDo
//
//  Created by Giovane Possebon on 21/6/18.
//  Copyright © 2018 possebon. All rights reserved.
//

import Foundation
import Alamofire

class Network {

    class func request(_ url: UrlBuilder, method: HTTPMethod = .get, parameters: Input? = nil, log: Bool = true, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping (DataResponse<Any>, APIError?) -> Void) {

        guard let url = try? url.asURL() else { return }

        Alamofire.request(url, method: method, parameters: parameters?.toDict, encoding: encoding, headers: defaultHeaders()).responseJSON(completionHandler: { response in
            if log { logAlamofireRequest(response: response) }

            if response.response?.statusCode == 401 {
                completion(response, API.handleAPIError(from: response))
            } else {
                completion(response, nil)
            }
        })
    }

    private class func defaultHeaders() -> [String: String] {
        let headers: [String: String] = [
            "Content-Type":"application/json",
            "Authorization": UserSession.shared.authToken,
        ]

        return headers
    }

    private class func logAlamofireRequest(response: DataResponse<Any>) {
        guard let request = response.request else { return }
        guard let url = request.url else { return }
        guard let httpMethod = request.httpMethod else { return }

        print("->REQUEST(\(httpMethod))\n\(url)\n")

        if let requestHeaders = request.allHTTPHeaderFields {
            print("->HEADERS\n\(requestHeaders)\n")
        }

        if let httpBody = request.httpBody {
            do {
                let jsonBody = try JSONSerialization.jsonObject(with: httpBody)
                print("->BODY\n\(jsonBody)\n")
            } catch {}
        }

        var statusCode = 0
        if let response = response.response {
            statusCode = response.statusCode
        }

        let statusCodeString = (statusCode != 0) ? "(\(statusCode))" : ""
        print("->RESPONSE" + statusCodeString + "\n\(response.description)")
    }
}
