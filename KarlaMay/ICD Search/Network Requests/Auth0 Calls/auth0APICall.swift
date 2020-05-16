//
//  auth0APICall.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation


func auth0APICall(apiEndPoint: String, additionalHeaders: [String:String]?, accessToken: String ) throws {
    
    let headers = [
      "content-type": "application/json",
      "authorization": "Bearer \(accessToken)"
    ]

    guard let url = URL(string: apiEndPoint) else {throw ICDSearchError.invalidURL}
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    if let additionalHeaders = additionalHeaders {
        for (key, value) in additionalHeaders { request.addValue(value, forHTTPHeaderField: key)}
    }

    URLSession.shared.dataTask(with: request){ (data, response, error) -> Void in
      if let error = error {
        print(error.localizedDescription)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200, let data = data {
            let dat = String(decoding: data, as: UTF8.self)
            print(dat)
        } else {
            print(httpResponse.statusCode)
        }
      }
    }.resume()
    
}
