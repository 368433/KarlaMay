//
//  auth0APICall.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-16.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//

import Foundation


func auth0APICall(apiEndPoint: String, additionalHeaders: [String:String]?, accessToken: String, completion: @escaping (Data?)->()) throws {
    
//    let headers = [
//      "Accept": "application/json",
//      "Authorization": "Bearer \(accessToken)"
//    ]
    let searchHeaders = [ "Authorization":  "Bearer \(accessToken)", "Accept": "application/json", "Accept-Language": "en", "API-Version": "v2"]

    guard let url = URL(string: apiEndPoint) else {throw ICDSearchError.invalidURL}
    var request = URLRequest(url: url)
    for (key, value) in searchHeaders {request.addValue(value, forHTTPHeaderField: key)}
//    request.httpMethod = "GET"
//    request.allHTTPHeaderFields = headers
//    if let additionalHeaders = additionalHeaders {
//        for (key, value) in additionalHeaders { request.addValue(value, forHTTPHeaderField: key)}
//    }

    URLSession.shared.dataTask(with: request){ (data, response, error) -> Void in
      if let error = error {
        print(error.localizedDescription)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
            DispatchQueue.main.async {
                completion(data)
            }
        } else {
            print(httpResponse.statusCode)
        }
      }
    }.resume()
    
}
